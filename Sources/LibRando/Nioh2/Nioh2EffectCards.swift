extension Nioh2 {

  struct GuardianSpiritCard: EffectCard {
    let guardianSpirit: GuardianSpirit
    let tone: EffectCardTone

    var description: String {
      "Guardian Spirit \(tone): \(guardianSpirit.name)"
    }
  }

}

extension Nioh2 {

  struct SoulCoreCard: EffectCard {
    let soulCore: SoulCore
    let tone: EffectCardTone

    var description: String {
      "Soul Core \(tone): \(soulCore.name)"
    }
  }

}
