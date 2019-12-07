##
# SpaceObject is a representation of a body of mass in space.
#   It orbits one other SpaceObject, and can be a Center of Mass for a orbital system.
class SpaceObject

    attr_accessor :orbits

    ##
    # Params
    #   name: name of the SpaceObject
    #   orbits: other SpaceObject that this orbits
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

    ##
    # Solves how many other items this SpaceObject's orbit SpaceObjects orbits
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

    ##
    # Solves the direct path from this to Center of Mass (COM)
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
