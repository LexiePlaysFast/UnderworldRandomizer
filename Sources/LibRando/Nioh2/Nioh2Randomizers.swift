extension Nioh2 {

  struct DepthsRandomizer: Randomizer {

    struct WeaponPair {
      let primary: Weapon
      let secondary: Weapon

      var areDifferent: Bool {
        primary != secondary
      }

      var cards: [EffectCard] {
        [ primary, secondary ]
          .map { WeaponCard(weapon: $0, tone: .required) }
      }
    }

    struct DepthsFloorEffect: FloorEffect {

      var description: String {
        """
        On floor \(floorNumber) of the Depths, the following modifiers are in effect:
          Required weapons:          \(weapons.primary.name) & \(weapons.secondary.name)
          Required guardian spirits: \(
            guardianSpirits.0.guardianSpirit.name
          ) & \(
            guardianSpirits.1.guardianSpirit.name
          )
          Required soul cores:       \(
            soulCores.0.0.soulCore.name
          ), \(
            soulCores.0.1.soulCore.name
          ) & \(
            soulCores.0.2.soulCore.name
          ); \(
            soulCores.1.0.soulCore.name
          ), \(
            soulCores.1.1.soulCore.name
          ) & \(
            soulCores.1.2.soulCore.name
          )
        """
      }

      let logicLevel: LogicLevel

      let floorNumber: Int

      let weapons: WeaponPair
      let guardianSpirits: (GuardianSpiritCard, GuardianSpiritCard)
      let soulCores: ((SoulCoreCard, SoulCoreCard, SoulCoreCard), (SoulCoreCard, SoulCoreCard, SoulCoreCard))

      var cards: [EffectCard] {
        [
          WeaponCard(weapon: weapons.primary, tone: .required),
          WeaponCard(weapon: weapons.secondary, tone: .required),
          guardianSpirits.0,
          guardianSpirits.1,
          soulCores.0.0,
          soulCores.0.1,
          soulCores.0.2,
          soulCores.1.0,
          soulCores.1.1,
          soulCores.1.2,
        ]
      }

      func validate(logicLevel: LogicLevel) -> Bool {
        guard
          logicLevel == self.logicLevel
        else {
          return false
        }

        let flatSoulCoresOne = [
          soulCores.0.0,
          soulCores.0.1,
          soulCores.0.2,
        ].map { $0.soulCore }

        let flatSoulCoresTwo = [
          soulCores.1.0,
          soulCores.1.1,
          soulCores.1.2,
        ].map { $0.soulCore }

        let flatSoulCores = flatSoulCoresOne + flatSoulCoresTwo

        let differentWeapons = weapons.areDifferent
        let differentGuardianSpirits = guardianSpirits.0.guardianSpirit != guardianSpirits.1.guardianSpirit
        let soulCoresUnique = Set(flatSoulCores.map { $0.name }).count == 6

        guard
          differentWeapons,
          differentGuardianSpirits,
          soulCoresUnique
        else {
          return false
        }

        let soulCoreCostOne: Int = flatSoulCoresOne
          .map { $0.attunementCost }
          .reduce(0, +)
        let soulCoreCostTwo: Int = flatSoulCoresTwo
          .map { $0.attunementCost }
          .reduce(0, +)

        guard
          guardianSpirits.0.guardianSpirit.attunementLimit >= soulCoreCostOne,
          guardianSpirits.1.guardianSpirit.attunementLimit >= soulCoreCostTwo
        else {
          return false
        }

        guard
          logicLevel == .enhanced
        else {
          return true
        }

        let guardianSpiritTypes = (guardianSpirits.0.guardianSpirit.type, guardianSpirits.1.guardianSpirit.type)

        let differentGuardianSpiritTypes = guardianSpiritTypes.0 != guardianSpiritTypes.1
        let oneBruteGuardianSpirit = guardianSpiritTypes.0 == .brute || guardianSpiritTypes.1 == .brute
        let soulCoresMatchGuardianSpirit =
          flatSoulCoresOne.allSatisfy { $0.type == guardianSpiritTypes.0 } &&
          flatSoulCoresTwo.allSatisfy { $0.type == guardianSpiritTypes.1 }

        guard
          differentGuardianSpiritTypes,
          oneBruteGuardianSpirit,
          soulCoresMatchGuardianSpirit
        else {
          return false
        }

        return true
      }
    }

    let guardianSpiritCards: [GuardianSpiritCard] = guardianSpirits.map {
      GuardianSpiritCard(guardianSpirit: $0, tone: .required)
    }

    let soulCoreCards: [SoulCoreCard] = soulCores.map {
      SoulCoreCard(soulCore: $0, tone: .required)
    }

    func basicCreateFloors() -> RandomizedFloors {
      var weapons = weapons.shuffled()
      var guardianSpirits = guardianSpiritCards.shuffled()
      var soulCores = soulCoreCards.shuffled()

      var floors: [FloorEffect] = []

      for floorNumber in 1...5 {
        floors
          .append(
            DepthsFloorEffect(
              logicLevel: .basic,
              floorNumber: floorNumber,
              weapons: WeaponPair(primary: weapons.removeFirst(), secondary: weapons.removeFirst()),
              guardianSpirits: (guardianSpirits.removeFirst(), guardianSpirits.removeFirst()),
              soulCores: (
                (soulCores.removeFirst(), soulCores.removeFirst(), soulCores.removeFirst()),
                (soulCores.removeFirst(), soulCores.removeFirst(), soulCores.removeFirst())
              )
            )
          )
      }

      let spareCards: [EffectCard] = [
        weapons.map { WeaponCard(weapon: $0, tone: .required) },
        guardianSpirits,
        soulCores,
      ].flatMap { $0 as! [EffectCard] }

      return RandomizedFloors(floors: floors, spareCards: spareCards)
    }

    func enhancedCreateFloors() -> RandomizedFloors {
      var weapons = weapons.shuffled()

      let guardianSpirits = guardianSpiritCards.shuffled()
      var bruteGuardianSpirits = guardianSpirits.filter {
        $0.guardianSpirit.type == .brute
      }
      var nonBruteGuardianSpirits = guardianSpirits.filter {
        $0.guardianSpirit.type != .brute
      }

      let soulCores = soulCoreCards.shuffled()
      var bruteSoulCores = soulCores.filter {
        $0.soulCore.type == .brute
      }
      var feralSoulCores = soulCores.filter {
        $0.soulCore.type == .feral
      }
      var phantomSoulCores = soulCores.filter {
        $0.soulCore.type == .phantom
      }

      var floors: [FloorEffect] = []

      for floorNumber in 1...5 {
        let weapons = WeaponPair(primary: weapons.removeFirst(), secondary: weapons.removeFirst())
        let guardianSpirits = (bruteGuardianSpirits.removeFirst(), nonBruteGuardianSpirits.removeFirst())

        let soulCoresOne = (bruteSoulCores.removeFirst(), bruteSoulCores.removeFirst(), bruteSoulCores.removeFirst())
        let soulCoresTwo = guardianSpirits.1.guardianSpirit.type == .feral
          ? (feralSoulCores.removeFirst(),   feralSoulCores.removeFirst(),   feralSoulCores.removeFirst()  )
          : (phantomSoulCores.removeFirst(), phantomSoulCores.removeFirst(), phantomSoulCores.removeFirst())

        floors.append(
          DepthsFloorEffect(
            logicLevel: .enhanced,
            floorNumber: floorNumber,
            weapons: weapons,
            guardianSpirits: guardianSpirits,
            soulCores: (soulCoresOne, soulCoresTwo)
          )
        )
      }

      let spareCards: [EffectCard] = [
        weapons.map { WeaponCard(weapon: $0, tone: .required) },
        bruteGuardianSpirits,
        nonBruteGuardianSpirits,
        bruteSoulCores,
        feralSoulCores,
        phantomSoulCores,
      ].flatMap { $0 as! [EffectCard] }

      return RandomizedFloors(
        logicLevel: .enhanced,
        floors: floors,
        spareCards: spareCards
      )
    }

    func createFloors(logicLevel: LogicLevel) -> RandomizedFloors {
      switch logicLevel {
      case .basic:
        return basicCreateFloors()
      case .enhanced:
        return enhancedCreateFloors()
      }
    }

    func randomize(logicLevel: LogicLevel) -> RandomizedFloors {
      while true {
        let floors = createFloors(logicLevel: logicLevel)

        if (floors.validate(logicLevel: logicLevel)) {
          return floors
        }
      }
    }

  }

}
