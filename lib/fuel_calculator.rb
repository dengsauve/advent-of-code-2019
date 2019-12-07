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