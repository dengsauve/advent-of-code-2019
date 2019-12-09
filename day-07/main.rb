require_relative '../lib/aoc_lib.rb'

input = open('input.txt').read().split(",")
#input = "3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0".split(",")
#input = "3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0".split(",")
#input = "3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0".split(",")

def get_output(amp_a, amp_b, amp_c, amp_d, amp_e, phase_sequence)
    signal_a = 0
    signal_b = amp_a.solve_amp(phase_sequence[0], signal_a)
    signal_c = amp_b.solve_amp(phase_sequence[1], signal_b)
    signal_d = amp_c.solve_amp(phase_sequence[2], signal_c)
    signal_e = amp_d.solve_amp(phase_sequence[3], signal_d)
    output_signal = amp_e.solve_amp(phase_sequence[4], signal_e)
    return output_signal
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
    phase_options = [0,1,2,3,4]

    #puts get_output(amp_a, amp_b, amp_c, amp_d, amp_e, phase_sequence)
    puts find_max_output(amp_a, amp_b, amp_c, amp_d, amp_e, phase_options)
end

def part_two(input)

end

part_one(input)
