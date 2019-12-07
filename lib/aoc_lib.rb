##
# IntComp is a computer that parses a comma separated string of integers and
#   parses it into commands via the "solve" method.
require_relative 'int_code_computer.rb'


##
# SpaceObject
class SpaceObject

    attr_accessor :orbits
    def initialize(name, orbits)
        @name = name.strip
        @COM = name == "COM"
        @orbits = orbits
    end

    def is_com?
        @COM
    end

    def to_s
        return "COM" if @COM
        "#{@name} orbits #{@orbits}"
    end

    def indirect_orbits(count=-1)
        unless @COM
            if @orbits
                return @orbits.indirect_orbits(count + 1)
            else
                return count
            end
        else
            return count >= 0 ? count : 0
        end
    end

    def path_to_com(path=[])
        path.push(@name)
        unless @COM
            if @orbits
                return @orbits.path_to_com(path)
            else
                return path
            end
        else
            return path
        end
    end

end


##
# FuelCalculator takes a list modules' masses, and can return the amount of
#   fuel needed to launch that payload into space
class FuelCalculator

    ##
    # Params:
    #   Modules: list of comma separated integers representing mass of modules
    def initialize(modules)
        @modules = modules
        @sum = 0
    end

    ##
    # Solves for the amount of fuel needed for all modules
    #
    # Params:
    #   fuel=false: Determines whether to solve for the amount of fuel needed
    #       for the mass of the fuel.
    def solve(fuel=false)
        @modules.each do | mass |
            @sum += (mass.to_i / 3 - 2)
            get_fuel(( mass.to_i / 3 - 2)) if mass.to_i >= 9 && fuel
        end

        return @sum
    end

    ##
    # Based on a mass, returns amount of fuel needed for fuel, recursively.
    #
    # Params:
    #   mass: integer of mass of fuel to be solved for
    def get_fuel(mass)
        mass = mass / 3 - 2
        @sum += mass
        get_fuel(mass) if mass >= 9
    end

end


##
# Manhattan Distance finder solves for the intersections of two lines relative
#   to their shared origin.
class ManhattanDistanceFinder

    ##
    # Params:
    #   cmdset is an array of strings matching "[UDLR]\d+"
    def initialize(cmdset)
        @cmdset = cmdset
    end

    ##
    # Solves the intersection closest to the origin by "manhattan" distance
    def solve()
        intersections = get_intersections()
        sorted = intersections.sort_by{|e| e[0].abs + e[1].abs}
        return sorted[0][0].abs + sorted[0][1].abs
    end

    ##
    # Solves the intersection closest to the origin by stepping distance
    def solveFewestSteps()
        intersections = get_intersections()
        l1r, l2r = get_intersections(intersections)

        combined = []
        l1r.each do |r|
            l2r.each do |rr|
                if r[0] == rr[0] && r[1] == rr[1]
                    combined.push([r[0], r[1], r[2] + rr[2]])
                end
            end
        end

        combined = combined.sort_by{|x| x[2]}

        return combined[0][2]
    end

    ##
    # Params
    #   intersections(optional): Intersections is a list of points. If this is
    #       passed, it triggers the return of two separate lists with steps tracked
    def get_intersections(intersections=nil)
        return_steps = intersections != nil
        
        line_1 = []
        line_2 = []

        @cmdset.each_with_index do | cmdset, i |
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
                    
                    if(return_steps)
                        if intersections.include?([x,y])
                            line_1.push([x,y,steps]) if i == 0
                            line_2.push([x,y,steps]) if i == 1
                        end
                    else
                        line_1.push([x,y]) if i == 0
                        line_2.push([x,y]) if i == 1
                    end
                end
            end
        end

        if(return_steps)
            return line_1, line_2
        else
            intersections = line_1 & line_2
            return intersections
        end
    end    
end