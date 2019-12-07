require_relative '../lib/aoc_lib.rb'

input = open("input.txt").read().split("\n")
#input = "COM)B\nC)D\nB)C\nD)E\nE)F\nB)G\nG)H\nD)I\nE)J\nJ)K\nK)L".split("\n")
#input = "COM)B\nB)C\nC)D\nD)E\nE)F\nB)G\nG)H\nD)I\nE)J\nJ)K\nK)L\nK)YOU\nI)SAN".split("\n")

def create_space_objects(input)
    space_objects = {}

    input.each do |entry|
        orbit = entry.split(")")
        obj_a = orbit[0]
        obj_b = orbit[1]
        unless space_objects.key?(obj_a)
            space_objects[obj_a] = SpaceObject.new(obj_a, nil)
        end
        unless space_objects.key?(obj_b)
            space_objects[obj_b] = SpaceObject.new(obj_b, space_objects[obj_a])
        else
            space_objects[obj_b].orbits=(space_objects[obj_a])
        end
    end

    return space_objects
end


def part_two(input)
    space_objects = create_space_objects(input)

    you = space_objects["YOU"]
    san = space_objects["SAN"]

    you_com = you.path_to_com.reverse
    san_com = san.path_to_com.reverse

    index = 0

    while you_com[index + 1] == san_com[index + 1] do
        index += 1
    end

    you_com = you_com[index..-1]
    san_com = san_com[index..-1]

    puts you_com.length + san_com.length - 4
end


def part_one(input)
    space_objects = create_space_objects(input)

    sum = 0

    space_objects.each  do |k,v| 
        sum += v.indirect_orbits
        unless v.is_com?
            sum += 1
        end
    end

    puts sum
end

#part_one(input)
part_two(input)