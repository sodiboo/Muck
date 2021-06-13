The crimson dagger allows you to heal when you deal damage. It has a cumulative distribution function with a scale speed of 0.1 and a max value of 0.5, which is the multiplier of the damage you dealt which is applied to your healing. With maxed crimson dagger, you will heal half the damage you deal. It also applies to resources.

Healing only happens in integer numbers, so if the amount you should heal is not an integer, it is rounded *upwards* to the smallest integer that is greater than the health you would have gotten. For example, if you deal 158.2 damage, and you have 50% lifesteal, you should heal 79.1 hp, but it is rounded *up* so you'll heal 80 hp instead.

Here's the graph of how much lifesteal you get:

[![image]][link]

And here are the first few numbers for that graph:

cum: `${n(50, calc(0.1, 50))}% of damage dealt heals you back`

[image]: Images/dagger.png
[link]: https://www.desmos.com/calculator/uflefvarjl