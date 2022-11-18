extension Nioh2 {

  struct BossBingoSquare: BingoCardSquare {

    let boss: Boss

    var summary: String {
      "Defeat \(boss.name)"
    }

    var description: String {
      "\(summary)."
    }

  }

  struct GuardianSpiritBingoSquare: BingoCardSquare {

    let guardianSpirit: GuardianSpirit

    var summary: String {
      "Use \(guardianSpirit.name)"
    }

    var description: String {
      "Defeat a boss while being attuned to the guardian spirit \(guardianSpirit.name)."
    }

  }

  struct SoulCoreTripletBingoSquare: BingoCardSquare {

    struct SoulCoreTriplet {
      let soulCores: [SoulCore]

      init(soulCores: [SoulCore]) {
        self.soulCores = soulCores

        precondition(soulCores.count == 3, "Incorrect number of soul cores, expected 3")
      }

      static func draw(from cores: [SoulCore]) -> SoulCoreTriplet {
        let cores = cores.shuffled()

        let selection: [SoulCore] = [
          cores.first { $0.type == .feral },
          cores.first { $0.type == .brute },
          cores.first { $0.type == .phantom },
        ].compactMap { $0 }

        return Self(soulCores: selection)
      }

      var first: SoulCore {
        soulCores[0]
      }

      var second: SoulCore {
        soulCores[1]
      }

      var third: SoulCore {
        soulCores[2]
      }

    }

    init(from selection: [SoulCore]) {
      self.triplet = .draw(from: selection)
    }

    let triplet: SoulCoreTriplet

    var summary: String {
      "\(triplet.first.name), \(triplet.second.name), or \(triplet.third.name)"
    }

    var description: String {
      "Defeat any boss while having one of the soul cores \(summary) attuned to an active guardian spirit."
    }

  }

}
