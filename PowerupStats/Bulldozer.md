Each mob has a "knockback threshold" which is a fraction, the amount of damage you need to deal to also deal knockback. This is set per-mob, but for most of them it's 20% of their total health. One notable exception is big chunk, which is 100%, meaning you can never deal knockback because you'd need to kill him to deal knockback, and knockback is not dealt when the enemy dies.

The bulldozer powerup is has a cumulative distribution with a scale speed of 0.15 and a max value of 1. It is the chance you have to deal knockback, even if you did not deal the proper amount of damage. Here's a graph showing how that increases as you get more powerups:

[![image]][link]

You will deal knockback to a mob if you dealt sufficient damage OR bulldozer got you lucky. At 50 bulldozers, you're practically guaranteed to always deal knockback, including to Big Chunk.

Here's the chances in percentages for the first couple values:

cum: `${n(100, calc(0.15, 100))}% knockback chance`

[image]: Images/bulldozer.png
[link]: https://www.desmos.com/calculator/uorfleor84