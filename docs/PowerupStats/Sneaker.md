The sneaker makes you move faster. It doesn't actually make your acceleration faster or anything, it just multiplies the max speed before you stop accelerating. It also multiplies the counter movement, which is only when you're grounded and will bring you down to your max speed if you're moving above it. The sneaker has a cumulative distribution with a scale speed of 0.08 and a max value of 1.75, which is added to 1 as a base value. Here's the graph for that:

[![image]][link]

And here are the first couple values:

cum: `${n(2.75, 1 + calc(0.08, 1.75))}x max speed`

[image]: Images/sneakers.png
[link]: https://www.desmos.com/calculator/mlyvo6jgeu