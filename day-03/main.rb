require_relative '../lib/aoc_lib.rb'

input = open("input.txt").read().split("\n")

# 610 steps
# input = "R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83".split("\n")
# 410 steps
# input = "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7".split("\n")

input.each_with_index do | cmd, i |
    input[i] = cmd.split(',')
end

mdf = ManhattanDistanceFinder.new(input)
# Should be 1064
puts mdf.solve()
# Should be 25676
puts mdf.solveFewestSteps()