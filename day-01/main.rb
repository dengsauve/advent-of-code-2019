require_relative '../lib/aoc_lib.rb'

input = open("input.txt").readlines()

fc = FuelCalculator.new(input)

puts fc.solve(true)
# 6610877 too high
# 4433787 too low
# 4985158 was right on