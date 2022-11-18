struct WeaponBingoSquare: BingoCardSquare {

  let weapon: Weapon

  var summary: String {
    "Use \(weapon.name)"
  }

  var description: String {
    "Defeat a boss using the weapon: \(weapon.name)"
  }

}
