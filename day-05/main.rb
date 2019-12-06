require_relative '../lib/aoc_lib.rb'

input = open("input.txt").read().split(",")
#input = "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99".split(',')
#input = "3,3,1107,-1,8,3,4,3,99".split(',')
# input = "3,3,1108,-1,8,3,4,3,99".split(',')
# input = "3,9,7,9,10,9,4,9,99,-1,8".split(',')
# input = "3,9,8,9,10,9,4,9,99,-1,8".split(',')
comp = IntComp.new(input)
comp.solve()

# 16185138 is too high
# 2140710 is correct!