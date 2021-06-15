Robin Hood Hat has a cumulative distribution function with a scale speed of 0.06 and a max value of 2. It is added to the base value of 1 and it is used in these calculations:

- The time it takes to charge your bow is always divided by the robin value (i.e. 2x robin = half as long to charge the bow).
- The force that is added to an arrow when you shoot it is always multiplied by the robin value
- The damage that an arrow will deal when you fire it is always multiplied by the robin value

[![image]][link]

cum: `${n(3, 1 + calc(0.06, 2))}x bow charge speed, arrow velocity, arrow damage`

[image]: Images/robin.png
[link]: https://www.desmos.com/calculator/teb2g6bzsh