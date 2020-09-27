input = open("input.txt").readline

# figure image dimensions
width = 25
height = 6
area = width * height
rows = input.length / area

puts input, width, height, area, rows

class SpaceImage

  def initialize(width, height, input)
    @width = width
    @height = height
    @input = input
    @layers = []

    self.make_layers
  end

  def make_layers
    # Clear existing layers
    @layers = []

    @input.split('').each_slice(self.area).to_a.each_with_index do | l, i |
      layer = SpaceImageLayer.new(l.join, i)
      @layers << layer
    end
  end

  def get_layer_with_fewest_zeros
    ret_layer = @layers[0]
    min = ret_layer.get_zero_count

    @layers.each do |layer|
      zero_count = layer.get_zero_count
      if zero_count < min
        ret_layer = layer
        min = zero_count
      end
    end

    ret_layer
  end

  def area
    @width * @height
  end

end

class SpaceImageLayer

  attr_accessor :input, :index

  def initialize(input, index)
    @input = input
    @index = index
  end

  def get_zero_count
    puts "layer: #{index}, #{@input.scan(/0/).length}"
    @input.scan(/0/).length
  end

  def get_one_count
    @input.scan(/1/).length
  end

  def get_two_count
    @input.scan(/2/).length
  end

  def get_number_of_ones_times_twos
    self.get_one_count * self.get_two_count
  end

  def to_s
    ret_string = "layer #{@index} \n"
  end
end

index = 0

image = SpaceImage.new(width, height, input)
fewest_zero_layer = image.get_layer_with_fewest_zeros
puts fewest_zero_layer
puts fewest_zero_layer.get_number_of_ones_times_twos

# 2242 was too high

