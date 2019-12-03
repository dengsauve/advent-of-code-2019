require_relative '../lib/aoc_lib.rb'

input = open("input.txt").read().split("\n")
puts input.inspect

#input = "R8,U5,L5,D3\nU7,R6,D4,L4".split("\n")
input.each_with_index do | cmd, i |
    input[i] = cmd.split(',')
end

# puts input.inspect

line_1 = []
line_2 = []

input.each_with_index do | cmdset, i |
    x = 0
    y = 0

    cmdset.each do | cmd |
        instruction = cmd[0]
        distance = cmd[1..-1].to_i
        
        distance.times do
            case instruction
            when "R"
                x += 1
            when "L"
                x -= 1
            when "U"
                y += 1
            when "D"
                y -= 1
            end

            line_1.push([x,y]) if i == 0
            line_2.push([x,y]) if i == 1
        end
        
    end
end

results = line_1 & line_2

#puts (results).inspect

sorted = results.sort_by{|e| e[0].abs + e[1].abs}
puts sorted.inspect
puts sorted[0][0].abs + sorted[0][1].abs