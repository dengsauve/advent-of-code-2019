require_relative '../lib/aoc_lib.rb'

input = open("input.txt").read().split("\n")
# puts input.inspect
# input = "R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83".split("\n")
# input = "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7".split("\n")
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

# get the intersections
intersections = line_1 & line_2

#puts (results).inspect

#sorted = results.sort_by{|e| e[0].abs + e[1].abs}
# puts sorted.inspect
# puts sorted[0][0].abs + sorted[0][1].abs

l1r = []
l2r = []

input.each_with_index do | cmdset, i |
    x = 0
    y = 0
    steps = 0

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

            steps += 1

            if i == 0
                l1r.push([x,y,steps]) if (intersections.include?([x,y]))
            else
                l2r.push([x,y,steps]) if (intersections.include?([x,y]))
            end
        end
        
    end
end

#puts results.inspect

combined = []
l1r.each do |r|
    l2r.each do |rr|
        if r[0] == rr[0] && r[1] == rr[1]
            combined.push([r[0], r[1], r[2] + rr[2]])
        end
    end
end

combined = combined.sort_by{|x| x[2]}

puts combined[0..10].inspect