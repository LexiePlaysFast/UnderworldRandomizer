import Foundation
import LibRando

print(
  """
    Welcome to dbur, the Deck Based Underworld randomizer!
    The following settings are in effect:
      Mode : interactive
      Game : Nioh 2
      Area : Depths, floors 1-5
      Logic: enhanced
    """
)
print("Generating deck...")

let deck = LibRando
  .game(named: "Nioh 2")!
  .randomizers["Depths Randomizer"]!
  .randomize(logicLevel: .enhanced)

print(
  """
    Deck generated

    Time begins when you press enter. Press enter when the first floor of the depths fades in.
    """
)

var times: [Date] = []

for floor in (deck) {
  _ = readLine()
  let newTime = Date()
  print(floor.description)

  if (times.count == 0) {
    print("\nTime started!")
  } else {
    print(
      "\nSegment time:", format( times.last!.distance(to: newTime)),
      "\nTotal time  :", format(times.first!.distance(to: newTime))
    )
  }

  times.append(newTime)
}

print("\nTime ends when you press enter. Press enter when the last floor of the depths fades out.")
_ = readLine()
let newTime = Date()

print(
  "\nSegment time:", format( times.last!.distance(to: newTime)),
  "\nTotal time  :", format(times.first!.distance(to: newTime))
)
