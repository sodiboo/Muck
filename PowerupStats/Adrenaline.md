The adrenaline boost is applied when you take damage, and as a result have less than 30% health. It lasts for 5 seconds and then has another 10 seconds cooldown before it can be activated again. When active, it multiplies the final result for your movement speed, stamina multiplier, and attack speed, by the adrenaline bonus. The adrenaline bonus is a cumulative distribution with a scale speed of 1 and a max value of 2, which is then added to 1 to get the final multiplier applied to the 3 aforementioned stats.

[![image]][link]

And here's how that looks for the first couple values:

cum: `${n(3, 1 + calc(1, 2))}x Attack Speed, Move Speed, Stamina Drain`

[image]: Images/adrenaline.png
[link]: https://www.desmos.com/calculator/vcrcljkc9j