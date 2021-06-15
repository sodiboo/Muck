Enforcer has a cumulative distribution function with a scale speed of 0.4 and a max value of 2. This value is multiplied by your velocity in u/s on all 3 axes (current velocity for melee, or at the time you fired an arrow for bows - for reference, you go about 8 u/s when walking, and 13 u/s when sprinting, without any powerups, and about 20 u/s when sprinting and jumping), and then it's divided by 20. The result is added to a base value of 1, which is the multiplier for how much damage you will deal. The numbers below are simplified to divide the max value 2 by 20 (because  that gives the same result).

[![plain-image]][plain-link]

That isn't very helpful though. What's a unit? It's not very intuitive. Here's a graph that uses the velocities listed above to get a real multiplier, instead of just an equation:

[![real-image]][real-link]
- Blue is walking
- Green is running
- Orange is jumping
- Dotted is the max

cum: `(1 + velocity*${n(0.1, calc(0.4, 0.1), 3)})x damage multiplier (walking is about ${n(1.8, 1+calc(0.4, 0.8))}, sprinting is about ${n(2.3, 1+calc(0.4, 1.3))}x, jumping is about ${n(3, 1+calc(0.4, 2))}x)`

[plain-image]: Images/enforcer.png
[plain-link]: https://www.desmos.com/calculator/a08cej4p0z
[real-image]: Images/enforcer_realworld.png
[real-link]: https://www.desmos.com/calculator/yuditwyvvj