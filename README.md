# Advent of Code - 2019
My code used to solve the problems in Advent of Code, 2019.

## Notes on each challenge

### Day 01

This was a fairly simple challeng - get the fuel needed for the cargo modules, then get the fuel needed for the fuel.
I took a recursive approach to solving fuel for fuel.

### Day 02

This one was a little more difficult just because there was so much going on on the challenge page story wise.
The gist was to create a parser for intcode program input. 

I took my sweet time on part two, and b/c I skipped the last line

>What is 100 * noun + verb? (For example, if noun=12 and verb=2, the answer would be 1202.)

I had some trouble submitting my answer for part two b/c I didn't format it correctly.

### Day 03

What a kludge, would have been done sooner with part two if I had separated my line lists the second time too.

Part 1 entailed parsing cardinal direction + distance commands, tracking intersection points, and eventually finding the intersection point between two lines with the least "manhattan distance" between it and the origin.

Part 2 was similar, except you had to find the intersection closest to the origin by number of steps. This involved "tracing" each wire, keeping track of the number of steps at each intersection, and finding the intersection with the least total number of steps from the origin.