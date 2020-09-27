##
# SpaceImage is a proprietary format for storing layered images
require_relative 'space_image.rb'

##
# IntComp is a computer that parses a comma separated string of integers and
#   parses it into commands via the "solve" method.
require_relative 'int_code_computer.rb'

##
# SpaceObject is a representation of a body of mass in space.
#   It orbits one other SpaceObject, and can be a Center of Mass for a orbital system.
require_relative 'space_object.rb'

##
# FuelCalculator takes a list modules' masses, and can return the amount of
#   fuel needed to launch that payload into space
require_relative 'fuel_calculator.rb'

##
# Manhattan Distance finder solves for the intersections of two lines relative
#   to their shared origin.
require_relative 'manhattan_distance_finder.rb'