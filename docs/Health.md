### How does mob health work?

Mobs have a base health. Depending on how the mob spawns, its real max health will be the base health with a multiplier.

- When a mob spawns from a shrine, it has 1.75x health
- A boss spawned from a shrine has 1.5x health, and another multiplier which increases by .1x for every additional player alive beyond the first player (i.e. 1 player = 1x, 2 players = 1.1x health)
- A regular boss has a health multiplier which increases by .15x for every additional player alive beyond the first player
- Starting at 6% for the first 5 days, every day after that adds another 1% chance to get 1.5x health, ending at day 30 (31%). This also defines a buff mob.
- All mob health is multiplied by the current day times the difficulty health base (0.2 for easy, 0.23 for normal, 0.28 for gamer), to the power of the difficulty health exponent (1.3 for easy, 1.54 for normal, 1.65 for gamer), plus the difficulty base multiplier value (0.9 for easy, 1.05 for normal, 1.3 for gamer). What the fuck does that mean? I don't know, here's some lines that show you why the base health is always way lower than you'd expect:

[![](mob.png)](https://www.desmos.com/calculator/dkoejbf993)
- Red: Easy
- Blue: Normal
- Green: Gamer