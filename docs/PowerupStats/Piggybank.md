The Piggybank has a cumulative distribution function with a scale speed of 0.15 and a max value of 1.25, and it is added to a base value of 1. The stack size of any items dropped from loot tables are multiplied by the piggybank's value. It is then truncated to an integer, meaning it will be floored (and *not* rounded, meaning if you were going to get 3 wood and have 2 piggybank = 1.32x, you would only get 3.9, which gets floored to just 3 and piggybank did nothing). The piggybank does not apply to the "Self" loot table, which is used for player-made structures.

Here's the graph of that multiplier:

[![Images/piggybank.png]][https://www.desmos.com/calculator/xfdaugzvdc]

And here are the first couple values:

cum: `${n(2.25, 1 + calc(0.15, 1.25))}x loot multiplier`

And also, if you were to slay as many pigs as Technoblade did in Hypixel Skyblock for his sword, but in Muck, the game would calculate you to get exactly 3x loot. WolframAlpha does the same, and gives you `3.` as the result (not `3`), whatever that means. Neither of these answers were satisfactory for me because this function doesn't ever actually hit the max value for any finite number as input, so i took to arbitrary-precision calculation and this is the result:

[![Images/piggysword.png]][https://apfloat.appspot.com/]

[sword]: Images/piggysword.png
[calculator]: https://apfloat.appspot.com/
[image]: Images/piggybank.png
[link]: https://www.desmos.com/calculator/xfdaugzvdc