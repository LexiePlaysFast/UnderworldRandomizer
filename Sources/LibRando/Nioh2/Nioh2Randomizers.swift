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

    struct SoulCoreSelection {
      let guardianSpirit: GuardianSpirit
      let soulCores: [SoulCore]

      init(guardianSpirit: GuardianSpirit, soulCores: SoulCore...) {
        self.guardianSpirit = guardianSpirit
        self.soulCores = soulCores

        precondition(soulCores.count == 3, "Incorrect number of soul cores, expected 3")
      }

      var totalCost: Int {
        soulCores
          .map { $0.attunementCost }
          .reduce(0, +)
      }

      var withinLimit: Bool {
        guardianSpirit.attunementLimit >= totalCost
      }

      var soulCoresMatchSpirit: Bool {
        soulCores
          .allSatisfy { $0.type == guardianSpirit.type }
      }
    }

    struct GuardianSpiritPair {
      let primary: SoulCoreSelection
      let secondary: SoulCoreSelection

      var areDifferent: Bool {
        primary.guardianSpirit != secondary.guardianSpirit
      }

      var areDifferentTypes: Bool {
        primary.guardianSpirit.type != secondary.guardianSpirit.type
      }

      var areDifferentElements: Bool {
        primary.guardianSpirit.element != secondary.guardianSpirit.element
      }

      var allSoulCores: [SoulCore] {
        primary.soulCores + secondary.soulCores
      }

      var guardianSpiritCards: [EffectCard] {
        [ primary.guardianSpirit, secondary.guardianSpirit ]
          .map { GuardianSpiritCard(guardianSpirit: $0, tone: .required) }
      }

      var soulCoreCards: [EffectCard] {
        allSoulCores
          .map { SoulCoreCard(soulCore: $0, tone: .required) }
      }

      var haveDifferentSoulCores: Bool {
        Set(allSoulCores.map { $0.name }).count == 6
      }

      var withinLimit: Bool {
        primary.withinLimit && secondary.withinLimit
      }

      var soulCoresMatchSpirit: Bool {
        primary.soulCoresMatchSpirit && secondary.soulCoresMatchSpirit
      }

      var cards: [EffectCard] {
        guardianSpiritCards + soulCoreCards
      }

      func oneIs(type: SpiritType) -> Bool {
        primary.guardianSpirit.type == type || secondary.guardianSpirit.type == type
      }
    }

    struct DepthsFloorEffect: FloorEffect {

      var description: String {
        """
        On floor \(floorNumber) of the Depths, the following modifiers are in effect:
          Required weapons:          \(weapons.primary.name) & \(weapons.secondary.name)
          Required guardian spirits: \(
            guardianSpirits.primary.guardianSpirit.name
          ) & \(
            guardianSpirits.secondary.guardianSpirit.name
          )
          Required soul cores:       \(
            "Foo"
          ), \(
            "Bar"
          ) & \(
            "Baz"
          ); \(
            "Foo"
          ), \(
            "Bar"
          ) & \(
            "Baz"
          )
        """
      }

      let logicLevel: LogicLevel

      let floorNumber: Int

      let weapons: WeaponPair
      let guardianSpirits: GuardianSpiritPair

      var cards: [EffectCard] {
        weapons.cards + guardianSpirits.cards
      }

      func validate(logicLevel: LogicLevel) -> Bool {
        guard
          logicLevel == self.logicLevel
        else {
          return false
        }

        guard
          weapons.areDifferent,
          guardianSpirits.areDifferent,
          guardianSpirits.haveDifferentSoulCores
        else {
          return false
        }

        guard
          guardianSpirits.withinLimit
        else {
          return false
        }

        guard
          logicLevel == .enhanced
        else {
          return true
        }

        guard
          guardianSpirits.areDifferentTypes,
          guardianSpirits.soulCoresMatchSpirit,
          guardianSpirits.oneIs(type: .brute)
        else {
          return false
        }

        return true
      }
    }

    func basicCreateFloors() -> RandomizedFloors {
      var weapons = weapons.shuffled()
      var guardianSpirits = guardianSpirits.shuffled()
      var soulCores = soulCores.shuffled()

      var floors: [FloorEffect] = []

      for floorNumber in 1...5 {
        floors
          .append(
            DepthsFloorEffect(
              logicLevel: .basic,
              floorNumber: floorNumber,
              weapons: WeaponPair(primary: weapons.removeFirst(), secondary: weapons.removeFirst()),
              guardianSpirits: GuardianSpiritPair(
                primary: SoulCoreSelection(
                  guardianSpirit: guardianSpirits.removeFirst(),
                  soulCores: soulCores.removeFirst(), soulCores.removeFirst(), soulCores.removeFirst()
                ),
                secondary: SoulCoreSelection(
                  guardianSpirit: guardianSpirits.removeFirst(),
                  soulCores: soulCores.removeFirst(), soulCores.removeFirst(), soulCores.removeFirst()
                )
              )
            )
          )
      }

      let spareCards: [EffectCard] =
        weapons.map {
          WeaponCard(weapon: $0, tone: .required)
        } +
        guardianSpirits.map {
          GuardianSpiritCard(guardianSpirit: $0, tone: .required)
        } +
        soulCores.map {
          SoulCoreCard(soulCore: $0, tone: .required)
        }

      return RandomizedFloors(floors: floors, spareCards: spareCards)
    }

    func enhancedCreateFloors() -> RandomizedFloors {
      var weapons = weapons.shuffled()

      let guardianSpirits = guardianSpirits.shuffled()
      var bruteGuardianSpirits = guardianSpirits.filter {
        $0.type == .brute
      }
      var nonBruteGuardianSpirits = guardianSpirits.filter {
        $0.type != .brute
      }

      let soulCores = soulCores.shuffled()
      var bruteSoulCores = soulCores.filter {
        $0.type == .brute
      }
      var feralSoulCores = soulCores.filter {
        $0.type == .feral
      }
      var phantomSoulCores = soulCores.filter {
        $0.type == .phantom
      }

      var floors: [FloorEffect] = []

      for floorNumber in 1...5 {
        let weapons = WeaponPair(primary: weapons.removeFirst(), secondary: weapons.removeFirst())
        let guardianSpirits = (bruteGuardianSpirits.removeFirst(), nonBruteGuardianSpirits.removeFirst())

        let soulCoresOne = (bruteSoulCores.removeFirst(), bruteSoulCores.removeFirst(), bruteSoulCores.removeFirst())
        let soulCoresTwo = guardianSpirits.1.type == .feral
          ? (feralSoulCores.removeFirst(),   feralSoulCores.removeFirst(),   feralSoulCores.removeFirst()  )
          : (phantomSoulCores.removeFirst(), phantomSoulCores.removeFirst(), phantomSoulCores.removeFirst())

        floors.append(
          DepthsFloorEffect(
            logicLevel: .enhanced,
            floorNumber: floorNumber,
            weapons: weapons,
            guardianSpirits: GuardianSpiritPair(
              primary: SoulCoreSelection(
                guardianSpirit: guardianSpirits.0,
                soulCores: soulCoresOne.0, soulCoresOne.1, soulCoresOne.2
              ),
              secondary: SoulCoreSelection(
                guardianSpirit: guardianSpirits.1,
                soulCores: soulCoresTwo.0, soulCoresTwo.1, soulCoresTwo.2
              )
            )
          )
        )
      }

      let spareCards: [EffectCard] =
        weapons.map {
          WeaponCard(weapon: $0, tone: .required)
        }
        + (bruteGuardianSpirits + nonBruteGuardianSpirits).map {
          GuardianSpiritCard(guardianSpirit: $0, tone: .required)
        }
        + (bruteSoulCores + feralSoulCores + phantomSoulCores).map {
          SoulCoreCard(soulCore: $0, tone: .required)
        }

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
