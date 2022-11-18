extension Nioh2 {

  class NewGamePlusBingomizer: Bingomizer {

    lazy var pool: [BingoCardSquare] = {
      var pool: [BingoCardSquare] = []

      pool += [
        (summary: "Pet a Cat", description: "Find and pet a scampuss."),
        (summary: "Triple Cat", description: "Be followed by three scampuss at once."),
        (summary: "Dog a Cat", description: "Defeat Hattori Hanzo, Nue, White Tiger or any fox spirit while being attuned to Makami or Okuri-Inu, or if not defeating a fox spirit, while having any fox spirit soul core attuned."),
        (summary: "Cat a Dog", description: "Defeat Maeda Toshiie, a ninken, or any fox spirit while escorted by a scampuss, while having the scampuss soul core attuned, or if not defeating a fox spirit, while having any fox spirit soul core attuned."),
        (summary: "Get Wet", description: "Bathe in a hot spring."),
        (summary: "Get Wetter", description: "Bathe in two hot springs during a single mission."),
        (summary: "Give Wet", description: "Drown an enemy."),
        (summary: "Get Weight", description: "Kill an enemy from above."),
        (summary: "Get Weightier", description: "Kill a boss while Over Encumbered."),
        (summary: "Fall Guy", description: "Kill an enemy by pushing them off a cliff."),
        (summary: "Traffic Lights", description: "Kill a boss while having three Oni-bi attuned to one Guardian Spirit and three Spirit Foxes attuned to another."),
        (summary: "Equivalent Exchange", description: "Trade with a sudama."),
        (summary: "Lightbringer", description: "Dispel two (non-boss) Dark Realms during a single mission."),
        (summary: "Modern Processor", description: "Collect and purify eight (8) soul cores in a single trip to a shrine (or mission end screen)."),
        (summary: "Antipodes", description: "Apply Confusion to a boss with Scorched and Saturated using Enenra and Suiki before killing it."),
        (summary: "Corrupting Storm", description: "Apply Confusion to a boss with Corruption, Scorched and Saturated using Janomecho, Enenra and Suiki in a single confusion chain, before killing it."),

        (summary: "Dot Dot Dot…", description: "Deal the killing blow to a boss with a damage over time effect such as Scorched or Poisoned."),
        (summary: "Ex-Adventurer", description: "Deal the killing blow to a boss with a regular arrow, ideally to the knee."),
        (summary: "Backhanded", description: "Deal the killing blow to a boss with a burst brute counter."),
        (summary: "Hidden Blade", description: "Deal the killing blow to a boss with any shuriken, kunai or rakansen coin."),
        (summary: "Ninth Symbol", description: "Deal the killing blow to a boss with any onymo magic shot."),
        (summary: "Kaboom!", description: "Deal the killing blow to a boss with any bomb (not including explosive cannon rounds)."),
        (summary: "Iai!", description: "Deal the killing blow to a boss with any sheathed ability (including Ultimate Sign of the Cross)."),
        (summary: "Swag Strats", description: "Deal the killing blow to a boss with Sword of Meditation."),
        (summary: "I Get By", description: "Deal the killing blow to a boss with a guardian spirit ability (in Yokai Shift, using a Fleeting Guardian Amulet, or using a Guardian Spirit Talisman)."),

        (summary: "Dear Mother", description: "Reach 5 stacks of Blood of the Yokai using Sarutahiko or Kurama Swordsmaster+ while fighting a boss before killing it."),
        (summary: "Pure Soul", description: "Reach 3 stacks of Cleaning Soul using Izanagi while fighting a boss before killing it."),
        (summary: "Versatile", description: "Reach 9 stacks of Versatility using Benzaiten or Susano while fighting a boss before killing it."),
        (summary: "Blocked!", description: "Reach 9 stacks of Rock Solid using Acala or Tranquil Foundations+ while fighting a boss before killing it."),
        (summary: "Revolutionary", description: "Reach 9 stacks of Death Dancer using Ame-no-Uzume while fighting a boss before killing it."),
        (summary: "Samsara", description: "Allow a proc of Living Dead using Izanami while fighting a boss before killing it."),
      ].map { ChallengeBingoSquare(summary: $0.summary, description: $0.description) }

      pool += weapons
        .map { WeaponBingoSquare(weapon: $0) }

      pool += bosses
        .map { BossBingoSquare(boss: $0) }

      pool += guardianSpirits
        .map { GuardianSpiritBingoSquare(guardianSpirit: $0) }

      pool += (1...100)
        .map { _ in SoulCoreTripletBingoSquare(from: soulCores) }

      return pool
    }()

  }

}
