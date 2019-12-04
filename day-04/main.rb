require_relative '../lib/aoc_lib.rb'

lb = 246515
ub = 739105

count = 0

def doubles_check(arr)
    tstring = arr.join()
    pass = false
    arr.each_with_index do |a,i|
        if tstring.match(/[^#{a}](#{a}){2}[^#{a}]/) || 
            tstring.match(/^(#{a}){2}[^#{a}]/) ||
            tstring.match(/[^#{a}](#{a}){2}$/)
            pass = true
        end
    end
    return pass
end

(lb..ub).each do |target|
#[111222].each do |target|
    passing = true
    prev = nil
    target = target.to_s.split('')

    target.each_with_index do |t,i|
        if i == 0
            prev = t
        else
            if t < prev
                passing = false
                break
            else
                prev = t
            end
        end
    end

    passing = doubles_check(target) if passing == true

    if passing == true
        count += 1
    end
end

puts count

#p1 1057 not right
#p1+2 137 not right
# 1048 right for first part, second should be less
# 301 not right
# 379 not right
# 409 not right
# 547 not correct
# 807 not right
# 892 not right