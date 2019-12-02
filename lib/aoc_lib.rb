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
# IntComp is a computer that parses a comma separated string of integers and
#   parses it into commands via the "solve" method.
class IntComp
    
    ##
    # Params:
    #   program: should be a comma seperated string of numbers
    def initialize(program)
        @program = program
        @ADD = 1
        @MULTIPLY = 2
        @STOP = 99
    end

    ##
    # Solves the program by moving 4 positions at a time:
    #   operator, val a position, val b position, and result position
    #   These are used to modify the program
    #
    # Params:
    #   a: custom variable for the first argument of the program sequence
    #   b: custom variable for the second argument of the program sequence
    def solve(a=nil, b=nil)
        program = @program.dup
        pointer = 0
        opcode = 0
        program[1] = a if a
        program[2] = b if b

        while (opcode != @STOP && pointer < program.length) do 
            opcode = program[pointer].to_i
            
            break if(opcode == @STOP)
            
            position_a = program[program[pointer + 1].to_i].to_i
            position_b = program[program[pointer + 2].to_i].to_i
            position_c = program[pointer + 3].to_i
            
            if(opcode == @ADD)
                program[position_c] = position_a + position_b
            elsif(opcode == @MULTIPLY)
                program[position_c] = position_a * position_b
            end

            pointer += 4
        end

        return program[0]
    end

end