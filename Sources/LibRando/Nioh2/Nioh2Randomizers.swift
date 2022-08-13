extension Nioh2 {

  struct DepthsRandomizer: Randomizer {

    struct DepthsFloorEffect: FloorEffect {

      var description: String {
        """
        On floor \(floorNumber) of the Depths, the following modifiers are in effect:
          Required weapons:          \(
            weapons.0.weapon.name
          ) & \(
            weapons.1.weapon.name
          )
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

      let floorNumber: Int

      let weapons: (WeaponCard, WeaponCard)
      let guardianSpirits: (GuardianSpiritCard, GuardianSpiritCard)
      let soulCores: ((SoulCoreCard, SoulCoreCard, SoulCoreCard), (SoulCoreCard, SoulCoreCard, SoulCoreCard))

      var cards: [EffectCard] {
        [
          weapons.0,
          weapons.1,
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

      func validate(logicLevel: LogicLevel = .basic) -> Bool {
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

        let differentWeapons = weapons.0.weapon != weapons.1.weapon
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

        if logicLevel == .basic {
          return true
        }

        return true
      }
    }

    let weaponCards:         [WeaponCard] = weapons.map {
      WeaponCard(weapon: $0, tone: .required)
    }

    let guardianSpiritCards: [GuardianSpiritCard] = guardianSpirits.map {
      GuardianSpiritCard(guardianSpirit: $0, tone: .required)
    }

    let soulCoreCards: [SoulCoreCard] = soulCores.map {
      SoulCoreCard(soulCore: $0, tone: .required)
    }

    func basicCreateFloors() -> RandomizedFloors {
      var weapons = weaponCards.shuffled()
      var guardianSpirits = guardianSpiritCards.shuffled()
      var soulCores = soulCoreCards.shuffled()

      var floors: [FloorEffect] = []

      for floorNumber in 1...5 {
        floors
          .append(
            DepthsFloorEffect(
              floorNumber: floorNumber,
              weapons: (weapons.removeFirst(),weapons.removeFirst()),
              guardianSpirits: (guardianSpirits.removeFirst(), guardianSpirits.removeFirst()),
              soulCores: (
                (soulCores.removeFirst(), soulCores.removeFirst(), soulCores.removeFirst()),
                (soulCores.removeFirst(), soulCores.removeFirst(), soulCores.removeFirst())
              )
            )
          )
      }

      return RandomizedFloors(floors: floors, spareCards: weapons)
    }

    func enhancedCreateFloors() -> RandomizedFloors {
      RandomizedFloors(floors: [])
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

        if (floors.validate()) {
          return floors
        } else {
          print("Discarded invalid draw")
        }
      }
    }

  }

}
