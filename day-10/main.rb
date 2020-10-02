# input = open("input.txt").readlines(chomp: true)

test_1_input = ".#..#
.....
#####
....#
...##".split("\n")

puts test_1_input.inspect

class AsteroidMap

  attr_accessor :asteroids

  def initialize(map)
    @map = map
    @asteroids = []
    self.parse_asteroids
  end

  def parse_asteroids
    @map.each_with_index do |row, ix|
      row.split("").each_with_index do |col, iy|
        if col == "#"
          @asteroids << Asteroid.new(iy, ix)
        end
      end
    end
  end

end

class Asteroid

  def initialize(position_x, position_y)
    @position_x = position_x
    @position_y = position_y
  end

  def to_s
    "#{@position_x}, #{@position_y}"
  end

end

def test_one(input)
  asteroid_map = AsteroidMap.new(input)
  puts asteroid_map.asteroids
end

test_one(test_1_input)