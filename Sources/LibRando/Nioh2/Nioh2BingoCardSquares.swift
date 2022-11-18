extension Nioh2 {

  struct BossBingoSquare: BingoCardSquare {

    let boss: Boss

    var summary: String {
      "Defeat \(boss.name)"
    }

    var description: String {
      summary
    }

  }

  struct GuardianSpiritBingoSquare: BingoCardSquare {

    let guardianSpirit: GuardianSpirit

    var summary: String {
      "Use \(guardianSpirit.name)"
    }

    var description: String {
      "Defeat a boss while being attuned to the guardian spirit \(guardianSpirit.name)"
    }

  }

}
