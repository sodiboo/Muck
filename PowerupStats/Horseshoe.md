This powerup determines how likely you are to perform critical damage. It has a base value of 10% (+0.1), and the additional chance is determined by the cumulative distribution function with a scale speed of 0.08 and max value of 0.9 (combined with the base value, equaling 100%). Here's a graph of that:

[![image]][link]

Here's a precalculated list of these first couple values:

cum: `${n(100, 10 + calc(0.08, 90))}% crit chance`

[image]: Images/horseshoe.png
[link]: https://www.desmos.com/calculator/5ms1mobjdi