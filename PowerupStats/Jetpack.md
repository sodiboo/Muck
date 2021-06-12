This powerup increases the force that is applied to your player when you jump. In other words, it increases your jump height. Specifically, it multiplies the jump force by the result of a cumulative distribution function plus one, with a scale speed of 0.075 and a max value of 2.5. Here's the graph for that:

[![image]][link]

And if you want the numbers, here's that too:

cum: `${n(3.5, 1 + calc(0.075, 2.5))}x jump force`

[link]: https://www.desmos.com/calculator/ldrgvtdjsz
[image]: Images/jetpack.png