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

### Day 04

Part one was deceptively easy, ended up just bruteforcing the pattern check.
I lost some time thinking about how I was going to optimize,
but it turns out that the I had a little less than 400000 numbers to check.

Part two was a little more wicked, and I got caught up trying to outsmart my earlier logic.
My final solution was a bit more elegant. I just checked for ascending order,
then sent that array to check against a pattern set for a clean pair of doubles.

### Day 05

I was sick this day, and hit hardest after 7. I spent about 80 minutes on this challenge, couldn't get part 1, and went to bed.

I woke up the next day, still sick, but was able to finish part 1 in 3 minutes. Part 2 took a bit longer, but finally got it. I'm planning on refactoring the IntCode Computer class before tonight's challenge.

### Day 06

This challenge seemed much more daunting than it truly was. First turned out easy enough, related SpaceObject objects to one another via "orbits", then just counted up the results from how many parents each object had.

The second challenge was oddly enough easier for me than the first part, I just applied the same logic to get a list of "YOU" and "SAN"'s path back to the COM, then found the divergence going in reverse, and added the length of the remainder of both lists together, minus 4 for you, your orbit, santa, and santa's orbit, and voila.