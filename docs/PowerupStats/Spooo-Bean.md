Spooo Bean has a cumulative distribution function with a scale speed of 0.2 and max value of 0.5. The value is inverted to go from 1 instead of 0 (1 - x). This value is a multiplier for how much hunger is drained (so the cap, 0.5, is half hunger drain).

[![image]][link]

cum: `${n(0.5, 1 - calc(0.2, 0.5))}x hunger drain`

[image]: Images/bean.png
[link]: https://www.desmos.com/calculator/zcp8a7ad4g