require_relative '../lib/aoc_lib.rb'

input = open("input.txt").readline
width = 25
height = 6

def part_1(image)
  fewest_zero_layer = image.get_layer_with_fewest_zeros
  puts "#{fewest_zero_layer}: #{fewest_zero_layer.get_number_of_ones_times_twos}"
end

def part_2(image)
  puts image.draw_image # JAFRA
end

image = SpaceImage.new(width, height, input)

part_1(image)
part_2(image)