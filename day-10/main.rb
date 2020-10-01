# input = open("input.txt").readlines(chomp: true)

test_1_input = ".#..#
.....
#####
....#
...##".split("\n")

puts test_1_input.inspect

class AsteroidMap

  def initialize(map)
    @map = map
  end

end

class Asteroid

  def initialize(position_x, position_y)
    @position_x = position_x
    @position_y = position_y
  end

end