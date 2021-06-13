This powerup is only applied if you are falling when you use a melee weapon, or if you were falling when you fired an arrow. It uses the cumulative distribution function with a scale speed of 0.45 and a max of 2.5, and then it adds 1 to that result (since it should increase your damage).

This results in a maximum multiplier of 3.5x. Here's a graph showing that visually:

[![image]][link]

And if you want the raw stats for your specific level, here are the first few values:

cum: `${n(3.5, 1 + calc(0.45, 2.5))}x damage when falling`

[link]: https://www.desmos.com/calculator/zfypygyxi8
[image]: Images/wings.png