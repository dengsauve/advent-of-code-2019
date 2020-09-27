require_relative '../lib/aoc_lib.rb'

input = open('input.txt').read().split(",")
#input = "3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0".split(",")
#input = "3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0".split(",")
#input = "3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0".split(",")
input = "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5".split(",")

def get_output(amp_a, amp_b, amp_c, amp_d, amp_e, phase_sequence)
    signal = 0
    all_stopped = [false, false, false, false, false]
    while(all_stopped.include?(false))
        unless amp_a.stopped
            signal = amp_a.solve_amp(phase_sequence[0], signal)
        else
            all_stopped[0] = true
        end
        unless amp_b.stopped
            signal = amp_b.solve_amp(phase_sequence[1], signal)
        else
            all_stopped[1] = true
        end
        unless amp_c.stopped
            signal = amp_c.solve_amp(phase_sequence[2], signal)
        else
            all_stopped[2] = true
        end
        unless amp_d.stopped
            signal = amp_d.solve_amp(phase_sequence[3], signal)
        else
            all_stopped[3] = true
        end
        unless amp_e.stopped
            signal = amp_e.solve_amp(phase_sequence[4], signal)
        else
            all_stopped[4] = true
        end
    end
    return signal
end

def find_max_output(amp_a, amp_b, amp_c, amp_d, amp_e, phase_options)
    max_output = 0
    
    phase_options.permutation.to_a.each do |permutation|
        output_signal = get_output(amp_a, amp_b, amp_c, amp_d, amp_e, permutation)
        max_output = output_signal if output_signal > max_output
    end

    return max_output
end

def part_one(input)
    amp_a = IntCodeComputer.new(input)
    amp_b = IntCodeComputer.new(input)
    amp_c = IntCodeComputer.new(input)
    amp_d = IntCodeComputer.new(input)
    amp_e = IntCodeComputer.new(input)
    #phase_sequence = [4,3,2,1,0]
    #phase_sequence = [0,1,2,3,4]
    #phase_sequence = [1,0,4,3,2]
    phase_options = (0..4).to_a

    #puts get_output(amp_a, amp_b, amp_c, amp_d, amp_e, phase_sequence)
    puts find_max_output(amp_a, amp_b, amp_c, amp_d, amp_e, phase_options)
end

def part_two(input)
    amp_a = IntCodeComputer.new(input, true)
    amp_b = IntCodeComputer.new(input, true)
    amp_c = IntCodeComputer.new(input, true)
    amp_d = IntCodeComputer.new(input, true)
    amp_e = IntCodeComputer.new(input, true)
    #phase_sequence = [4,3,2,1,0]
    #phase_sequence = [0,1,2,3,4]
    #phase_sequence = [1,0,4,3,2]
    phase_options = (5..9).to_a

    #puts get_output(amp_a, amp_b, amp_c, amp_d, amp_e, phase_sequence)
    puts find_max_output(amp_a, amp_b, amp_c, amp_d, amp_e, phase_options)
end

#part_one(input)
part_two(input)