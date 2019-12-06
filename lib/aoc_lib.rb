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
        @STORE = 3
        @READ = 4
        @JUMP_IF_TRUE = 5
        @JUMP_IF_FALSE = 6
        @LESS = 7
        @EQUALS = 8
        @STOP = 99
        @POS = 0
        @IMM = 1
        @DEBUG = true && false
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
            puts "pointer: #{pointer}" if @DEBUG
            opcode = program[pointer]

            # Immeidate Mode
            if(opcode.to_s.length > 2)
                opcode = opcode.to_s
                # need to parse that fancy code
                instruction = opcode[-2..-1].to_i
                puts "instruction: #{instruction}\nopcode: #{opcode}" if @DEBUG
                
                if(instruction == @STOP)
                    puts "STOP"
                    break
                end
                
                if (opcode.length == 3)
                    puts "length: 3" if @DEBUG
                    a = 0
                    b = 0
                    c = opcode[0].to_i
                elsif (opcode.length == 4)
                    puts "length: 4" if @DEBUG
                    a = 0
                    b = opcode[0].to_i
                    c = opcode[1].to_i
                elsif (opcode.length == 5)
                    puts "length: 5" if @DEBUG
                    a = opcode[0].to_i
                    b = opcode[1].to_i
                    c = opcode[2].to_i
                end

                puts "a: #{a}\nb: #{b}\nc: #{c}\n" if @DEBUG
                                
                if(instruction == @ADD || instruction == @MULTIPLY)
                    position_a = program[program[pointer + 1].to_i].to_i if c == 0
                    position_a = program[pointer + 1].to_i if c == 1

                    position_b = program[program[pointer + 2].to_i].to_i if b == 0
                    position_b = program[pointer + 2].to_i if b == 1

                    position_c = program[pointer + 3].to_i #if a == 0
                    #position_c = program[pointer + 3].to_i if a == 1
                
                    if(instruction == @ADD)
                        program[position_c] = position_a + position_b
                    elsif(instruction == @MULTIPLY)
                        program[position_c] = position_a * position_b
                    end
                    pointer += 4
                    puts "incrementing pointer by 4" if @DEBUG
                end

                if(instruction == @READ)
                    puts "\nSTATUS: #{program[pointer + 1]}\n"
                    pointer += 2
                    puts "incrementing pointer by 2" if @DEBUG
                end

                if(instruction == @STORE)
                    print "input: "
                    number = gets.strip
                    target = program[pointer + 1].to_i
                    program[target] = number.to_i
                    pointer += 2
                    puts "incrementing pointer by 2" if @DEBUG
                end

                # only two params
                if(instruction == @JUMP_IF_TRUE)
                    if c == 1
                        first = pointer + 1
                    else
                        first = program[pointer + 1].to_i
                    end

                    if b == 1
                        second = pointer + 2
                    else
                        second = program[pointer + 2].to_i
                    end

                    if @DEBUG
                        puts "first: #{first}\nsecond: #{second}"
                        puts "first_value: #{program[first]}\nsecond_value: #{program[second]}"
                    end

                    unless program[first].to_i == 0
                        pointer = program[second].to_i
                        puts "assigning pointer to #{pointer}" if @DEBUG
                    else
                        pointer += 3
                        puts "incrementing pointer by 3" if @DEBUG
                    end
                end

                # only two params
                if(instruction == @JUMP_IF_FALSE)
                    if c == 1
                        first = pointer + 1
                    else
                        first = program[pointer + 1].to_i
                    end

                    if b == 1
                        second = pointer + 2
                    else
                        second = program[pointer + 2].to_i
                    end
                    
                    if @DEBUG
                        puts "first: #{first}\nsecond: #{second}"
                        puts "first_value: #{program[first]}\nsecond_value: #{program[second]}"
                    end

                    if program[first].to_i == 0
                        pointer = program[second].to_i
                        puts "assigning pointer to #{pointer}" if @DEBUG
                    else
                        pointer += 3
                        puts "incrementing pointer by 3" if @DEBUG
                    end
                end

                # four parameters
                if(instruction == @LESS)
                    if c == 1
                        first = pointer + 1
                    else
                        first = program[pointer + 1].to_i
                    end

                    if b == 1
                        second = pointer + 2
                    else
                        second = program[pointer + 2].to_i
                    end

                    if a == 1
                        third = pointer + 3
                    else
                        third = program[pointer + 3].to_i
                    end

                    if(program[first].to_i < program[second].to_i)
                        program[third] = 1
                    else
                        program[third] = 0
                    end

                    pointer += 4
                end

                if(instruction == @EQUALS)
                    if c == 1
                        first = pointer + 1
                    else
                        first = program[pointer + 1].to_i
                    end

                    if b == 1
                        second = pointer + 2
                    else
                        second = program[pointer + 2].to_i
                    end

                    if a == 1
                        third = pointer + 3
                    else
                        third = program[pointer + 3].to_i
                    end

                    if(program[first].to_i == program[second].to_i)
                        program[third] = 1
                    else
                        program[third] = 0
                    end

                    pointer += 4
                end
            # Position Mode
            else
                opcode = opcode.to_i
                puts "ONLY opcode: #{opcode}" if @DEBUG
                if(opcode == @STOP)
                    puts "STOP"
                    break
                end
                
                if(opcode == @ADD || opcode == @MULTIPLY)
                    puts "Add or Multiply" if @DEBUG
                    position_a = program[program[pointer + 1].to_i].to_i
                    position_b = program[program[pointer + 2].to_i].to_i
                    position_c = program[pointer + 3].to_i
                
                    if(opcode == @ADD)
                        program[position_c] = position_a + position_b
                    elsif(opcode == @MULTIPLY)
                        program[position_c] = position_a * position_b
                    end
                    pointer += 4
                    puts "incrementing pointer by 4" if @DEBUG
                end
    
                if(opcode == @STORE)
                    puts "Store" if @DEBUG
                    print "input: "
                    number = gets.strip
                    target = program[pointer + 1].to_i
                    program[target] = number.to_i
                    puts "stored #{number} at #{target}" if @DEBUG
                    pointer += 2
                    puts "incrementing pointer by 2" if @DEBUG
                end
    
                if(opcode == @READ)
                    puts "Read" if @DEBUG
                    puts "\nSTATUS: #{program[program[pointer + 1].to_i]}\n"
                    pointer += 2
                    puts "incrementing pointer by 2" if @DEBUG
                end

                if(opcode == @JUMP_IF_TRUE)
                    puts "Jump if True" if @DEBUG
                    if @DEBUG
                        puts "first: #{program[pointer + 1]}\nsecond: #{second}"
                        puts "first_value: #{program[program[pointer + 1].to_i]}\nsecond_value: #{program[program[pointer + 2].to_i]}"
                    end
                    unless program[pointer + 1].to_i == 0
                        pointer = program[program[pointer + 2].to_i].to_i
                        puts "assigning pointer to #{pointer}" if @DEBUG
                    else
                        pointer += 3
                        puts "incrementing pointer by 3" if @DEBUG
                    end
                end

                if(opcode == @JUMP_IF_FALSE)
                    puts "Jump if False" if @DEBUG
                    if program[pointer + 1].to_i == 0
                        pointer = program[program[pointer + 2].to_i].to_i
                        puts "assigning pointer to #{pointer}" if @DEBUG
                    else
                        pointer += 3
                        puts "incrementing pointer by 3" if @DEBUG
                    end
                end

                if(opcode == @LESS)
                    puts "Less than" if @DEBUG
                    first = program[pointer + 1].to_i
                    second = program[pointer + 2].to_i
                    third = program[pointer + 3].to_i

                    puts "first_value: #{program[first]}\nsecond_value: #{program[second]}\nthird_value: #{program[second]}" if @DEBUG

                    if(program[first].to_i < program[second].to_i)
                        puts "setting 1 to position #{third}"
                        program[third] = 1
                    else
                        puts "setting 0 to position #{third}"
                        program[third] = 0
                    end

                    pointer += 4
                    puts "incrementing pointer by 4" if @DEBUG
                end

                if(opcode == @EQUALS)
                    puts "Equals" if @DEBUG
                    first = program[pointer + 1].to_i
                    second = program[pointer + 2].to_i
                    third = program[pointer + 3].to_i

                    puts "first_value: #{program[first]}\nsecond_value: #{program[second]}\nthird_value: #{program[second]}" if @DEBUG

                    if(program[first].to_i == program[second].to_i)
                        puts "setting 1 to position #{third}"
                        program[third] = 1
                    else
                        puts "setting 0 to position #{third}"
                        program[third] = 0
                    end

                    pointer += 4
                    puts "incrementing pointer by 4" if @DEBUG
                end
            end
            gets if @DEBUG
        end

        return program[0]
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