require_relative '../lib/aoc_lib.rb'

input = open("input.txt").read().split(',')
intcomp = IntComp.new(input)

100.times do |a|
    100.times do |b|
        result = intcomp.solve(a,b)

        puts "#{a}, #{b}: 100 * #{a} + #{b} = #{100 * a + b}" if (result == 19690720)
    end
end