##
# IntComp is a computer that parses a comma separated string of integers and
#   parses it into commands via the "solve" method.
class IntCodeComputer
    
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
            a = 0
            b = 0
            c = 0

            # Check Immeidate Mode
            if(opcode.to_s.length > 2)
                opcode = opcode.to_s
                # need to parse that fancy code
                instruction = opcode[-2..-1].to_i
                puts "instruction: #{instruction}\nopcode: #{opcode}" if @DEBUG
                
                if (opcode.length == 3)
                    puts "length: 3" if @DEBUG
                    c = opcode[0].to_i
                elsif (opcode.length == 4)
                    puts "length: 4" if @DEBUG
                    b = opcode[0].to_i
                    c = opcode[1].to_i
                elsif (opcode.length == 5)
                    puts "length: 5" if @DEBUG
                    a = opcode[0].to_i
                    b = opcode[1].to_i
                    c = opcode[2].to_i
                end
            else
                puts "opcode only: #{opcode}" if @DEBUG
                instruction = opcode.to_i
            end

            if(instruction == @STOP)
                puts "STOP"
                break
            end

            puts "a: #{a}\nb: #{b}\nc: #{c}\n" if @DEBUG
                            
            if(instruction == @ADD || instruction == @MULTIPLY)
                position_a = program[pointer + 1].to_i
                position_a = program[position_a].to_i if c == 0

                position_b = program[pointer + 2].to_i
                position_b = program[position_b].to_i if b == 0

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
                if (c == 0)
                    puts "\nSTATUS: #{program[program[pointer + 1].to_i]}\n"
                else
                    puts "\nSTATUS: #{program[pointer + 1]}\n"
                end
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
                puts "Jump if true" if @DEBUG
                first = pointer + 1
                first = program[first].to_i if c == 0

                second = pointer + 2
                second = program[second].to_i if b == 0

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
                puts "Jump if false" if @DEBUG

                first = pointer + 1
                first = program[first].to_i if c == 0

                second = pointer + 2
                second = program[second].to_i if b == 0
                
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
                puts "Less" if @DEBUG

                first = pointer + 1
                first = program[first].to_i if c == 0

                second = pointer + 2
                second = program[second].to_i if b == 0

                third = pointer + 3
                third = program[third].to_i if a == 0

                if(program[first].to_i < program[second].to_i)
                    program[third] = 1
                else
                    program[third] = 0
                end

                pointer += 4
            end

            if(instruction == @EQUALS)
                puts "Equals" if @DEBUG

                first = pointer + 1
                first = program[pointer + 1].to_i if c == 0

                second = pointer + 2
                second = program[second].to_i if b == 0

                third = pointer + 3
                third = program[third].to_i if a == 0

                puts "first: #{program[first]}, second: #{program[second]}" if @DEBUG

                if(program[first].to_i == program[second].to_i)
                    puts "Setting #{third} to 1" if @DEBUG
                    program[third] = 1
                else
                    puts "Setting #{third} to 0" if @DEBUG
                    program[third] = 0
                end

                pointer += 4
            end
            gets if @DEBUG
        end
    return program[0]
    end


    ##
    # Solves the program by moving 4 positions at a time:
    #   operator, val a position, val b position, and result position
    #   These are used to modify the program
    #
    # Params:
    #   phase: tells
    #   b: custom variable for the second argument of the program sequence
    def solve_amp(phase, signal)
        program = @program.dup
        pointer = 0
        opcode = 0
        input_times = 0

        while (opcode != @STOP && pointer < program.length) do 
            puts "pointer: #{pointer}" if @DEBUG
            opcode = program[pointer]
            a = 0
            b = 0
            c = 0

            # Check Immeidate Mode
            if(opcode.to_s.length > 2)
                opcode = opcode.to_s
                # need to parse that fancy code
                instruction = opcode[-2..-1].to_i
                puts "instruction: #{instruction}\nopcode: #{opcode}" if @DEBUG
                
                if (opcode.length == 3)
                    puts "length: 3" if @DEBUG
                    c = opcode[0].to_i
                elsif (opcode.length == 4)
                    puts "length: 4" if @DEBUG
                    b = opcode[0].to_i
                    c = opcode[1].to_i
                elsif (opcode.length == 5)
                    puts "length: 5" if @DEBUG
                    a = opcode[0].to_i
                    b = opcode[1].to_i
                    c = opcode[2].to_i
                end
            else
                puts "opcode only: #{opcode}" if @DEBUG
                instruction = opcode.to_i
            end

            if(instruction == @STOP)
                puts "STOP"
                break
            end

            puts "a: #{a}\nb: #{b}\nc: #{c}\n" if @DEBUG
                            
            if(instruction == @ADD || instruction == @MULTIPLY)
                position_a = program[pointer + 1].to_i
                position_a = program[position_a].to_i if c == 0

                position_b = program[pointer + 2].to_i
                position_b = program[position_b].to_i if b == 0

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
                if (c == 0)
                    # puts "\nSTATUS: #{program[program[pointer + 1].to_i]}\n"
                    return program[program[pointer + 1].to_i]
                else
                    # puts "\nSTATUS: #{program[pointer + 1]}\n"
                    return program[pointer + 1]
                end
                pointer += 2
                puts "incrementing pointer by 2" if @DEBUG
            end

            if(instruction == @STORE)
                #print "input: "
                if input_times == 0
                    number = phase
                    input_times += 1
                else
                    number = signal
                end
                target = program[pointer + 1].to_i
                program[target] = number.to_i
                pointer += 2
                puts "incrementing pointer by 2" if @DEBUG
            end

            # only two params
            if(instruction == @JUMP_IF_TRUE)
                puts "Jump if true" if @DEBUG
                first = pointer + 1
                first = program[first].to_i if c == 0

                second = pointer + 2
                second = program[second].to_i if b == 0

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
                puts "Jump if false" if @DEBUG

                first = pointer + 1
                first = program[first].to_i if c == 0

                second = pointer + 2
                second = program[second].to_i if b == 0
                
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
                puts "Less" if @DEBUG

                first = pointer + 1
                first = program[first].to_i if c == 0

                second = pointer + 2
                second = program[second].to_i if b == 0

                third = pointer + 3
                third = program[third].to_i if a == 0

                if(program[first].to_i < program[second].to_i)
                    program[third] = 1
                else
                    program[third] = 0
                end

                pointer += 4
            end

            if(instruction == @EQUALS)
                puts "Equals" if @DEBUG

                first = pointer + 1
                first = program[pointer + 1].to_i if c == 0

                second = pointer + 2
                second = program[second].to_i if b == 0

                third = pointer + 3
                third = program[third].to_i if a == 0

                puts "first: #{program[first]}, second: #{program[second]}" if @DEBUG

                if(program[first].to_i == program[second].to_i)
                    puts "Setting #{third} to 1" if @DEBUG
                    program[third] = 1
                else
                    puts "Setting #{third} to 0" if @DEBUG
                    program[third] = 0
                end

                pointer += 4
            end
            gets if @DEBUG
        end
    end
end