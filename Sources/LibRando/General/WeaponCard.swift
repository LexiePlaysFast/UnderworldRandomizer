struct WeaponCard: EffectCard {

  let weapon: Weapon
  let tone: EffectCardTone

  var description: String {
    "Weapon \(tone): \(weapon.name)"
  }

}
