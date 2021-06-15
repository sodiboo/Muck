Each sniper scope you collect gives you a higher chance to deal more damage.

The more sniper scopes you have, the higher chance you have to deal additional damage from it. This caps out at 0.2 (20%) and has a scale speed of 0.15. Here's a graph of the chance to deal additonal damage:
[![][chance-image]][chance-link]

If you're lucky and get the additional damage, the actual amount of damage you deal is multiplied by up to 50x its original value. That function has a scale speed of 0.25, and here's the graph for that:

###### note that the first chance determines whether your damage is multiplied by this value or not, sometimes the sniper scope will do absolutely nothing for you

[![damage-image]][damage-link]

And here is a precalculated list of the numbers for the first couple sniper scopes, if you'd rather have the current stats of your character than a graph of all of them:

cum: `${n(20, calc(0.15, 20))}% chance to deal ${n(50, calc(0.25, 50))}x damage`

[chance-image]: Images/sniper_chance.png
[chance-link]: https://www.desmos.com/calculator/vivzwiuqzm
[damage-image]: Images/sniper_damage.png
[damage-link]: https://www.desmos.com/calculator/akocvnn74b