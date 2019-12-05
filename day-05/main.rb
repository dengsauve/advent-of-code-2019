require_relative '../lib/aoc_lib.rb'

input = open("input.txt").read().split(",")
comp = IntComp.new(input)
comp.solve()