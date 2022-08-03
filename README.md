# The Nioh Underworld Randomizer

This is the start of a project to build an underworld randomizer for the Nioh games, with an initial focus on Nioh 2 in particular, also aiming to support Nioh (and potentially Wo Long, if the game ends up with anything like the Nioh underworld).

## Design

The randomizer is a separate program, run next to whichever version of the game the player uses. While this means that the actions of the randomizer have to be carried out manually, it also gives maximum compatiblity. The initially available frontend is `dbur` (pronounced like "deeper"), a console application.

Fundamentally, the randomizer works by drawing a series of modifiers from a deck of modifier cards. Using different decks, different draw strategies, and different numbers of cards for each floor, the difficulty and volatility of the randomiser can be adjusted to taste.

When playing, `dbur` displays the sequence of cards progressively, along some handy navigational data (_i.e._ the floor layout and boss name), with the next set of cards revealed when the player confirms the boss as dead.

## Challenge Timing Rules

- For a consistent result, challenges are compared only within the same system (PS5 vs. PS5, PS4 vs. PS4, PC vs. PC).
- Runs using ninjutsu feathers are timed separately from featherless runs.
- Time begins on the fade in on the first floor of the run (_i.e._ the first non-black frame, ignoring the load indicator).
- Time ends on the fade out after the last floor of the run (_i.e._ the first all-black frame, ignoring the load indicator).
- The timing of splits are intended to be identical to the run end time, to allow for certain comparisons between runs spanning different numbers of floors.
- The run can be ended either by engaging the amrita glow or talking to the crucible kodama, but timing is one fade out in either case; just talking to the kodama is not enough.

## Card Types

* Kodama tasks
  - Specific kodama (4 variants): Before entering the crucible, the player must have collected a specific jizo kodama
  - Sole kodama (4 variants): Before entering the crucible, the player may only collect a single, specified jizo kodama
  - Dual kodama (6 variants): Before entering the crucible, the player must collect the two specified jizo kodama, and _only_ the two specified jizo kodama
  - Triple kodama (4 variants): Before entering the crucible, the player must collect the three specified jizo kodama, leaving out the fourth
  - Adama (1 variant): Before entiring the crucible, the player must collect exactly one jizo kodama
  - Twodama (1 variant): Before entiring the crucible, the player must collect exactly two jizo kodama
  - Threedama (1 variant): Before entering the crucible, the player must collect exactly three jizo kodama
  - Quadama (1 variant): Before entering the crucible, the player must collect every jizo kodama
* Collection tasks
  - Sudama trader (1 variant): Before entering the crucible, the player must have traded with a sudama
  - Scampuss petter (1 variant): Before entering the crucible, the player must have petted a scampuss
  - Purple hunter (1 variant): Before entering the crucible, the player must have hunted down and killed a purple enemy
  - Dark Realm dispeller (1 variant): Before entering the crucible, the player must have dispelled a dark realm instance
* Equipment requirements
  - Required weapon (11 variants): The player must immediately replace the weapon they have been using the longest (or, in the case of the first switch, their secondary weapon) with the required weapon
  - Forbidden weapon (11 variants): The player must immediately replace, if applicable, the forbidden weapon with another of their choice
  - Required soul core (75 variants): The player must immediately equip the required soul core, replacing any (non-required) soul core
  - Forbidden soul core (75 variants): The player must immediately replace, if applicable, the forbidden soul core with another of their (non-forbbiden) choice
  - Required guardian spirit (37 variants): The player must immediately replace the guardian spirit they have been using the longest (or, in the case of the first switch, their secondary guardian spirit) with the required guardian spirit
  - Forbidden guardian spirit (37 variants): The player must immediately replace, if applicable, the forbidden guardian spirit with another of their (non-forbidden) choice

## Deck Autovetter

The randomizer will, as part of drawing cards, make sure that the run works. The simple autovetter does things like checking that the drawn deck doesn't require _e.g._ the player to trade with a sudama on a floor that doesn't have one. If given the player's starting gear (weapons, soul cores, guardian spirits) the randomizer can additionally make sure that none of the draws are wasted, by prohibiting things like forbidding equipment the player is not guaranteed to have.
