class SpaceImage

  def initialize(width, height, input)
    @width = width
    @height = height
    @input = input
    @layers = []
    @palette = [' ', 'w', ' ']

    self.make_layers
  end

  def make_layers
    # Clear existing layers
    @layers = []

    @input.split('').each_slice(self.area).to_a.each_with_index do | l, i |
      @layers << SpaceImageLayer.new(l.join, i)
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

  def draw_image
    ret_string = ""
    index = 0

    @height.times do |h|

      @width.times do |w|
        pixel = 2

        @layers.each do |l|
          value = l.input[index].to_i
          if value != 2
            pixel = value
            break
          end
          pixel = value
        end

        ret_string += @palette[pixel]
        index += 1
      end

      ret_string += "\n"
    end

    ret_string
  end

end

class SpaceImageLayer

  attr_accessor :input, :index

  def initialize(input, index)
    @input = input
    @index = index
  end

  def get_zero_count
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
    ret_string = "layer #{@index}"
  end
end