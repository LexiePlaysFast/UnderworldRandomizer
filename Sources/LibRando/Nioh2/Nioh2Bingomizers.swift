extension Nioh2 {

  class NewGamePlusBingomizer: Bingomizer {

    lazy var pool: [BingoCardSquare] = {
      var pool: [BingoCardSquare] = []

      pool += weapons
        .map { WeaponBingoSquare(weapon: $0) }

      pool += bosses
        .map { BossBingoSquare(boss: $0) }

      pool += guardianSpirits
        .map { GuardianSpiritBingoSquare(guardianSpirit: $0) }

      return pool
    }()

  }

}
