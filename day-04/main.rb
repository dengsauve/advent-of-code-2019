def doubles_check(arr)
    string = arr.join()
    arr.each_with_index do |a,i|
        if string.match(/[^#{a}](#{a}){2}[^#{a}]/) || 
            string.match(/^(#{a}){2}[^#{a}]/) ||
            string.match(/[^#{a}](#{a}){2}$/)
            return true
        end
    end
    return false
end

lower_bound = 246515
upper_bound = 739105
count = 0

(lower_bound..upper_bound).each do |target|
    passing = true
    previous_number = nil
    target = target.to_s.split('')

    target.each_with_index do |t,i|
        if i == 0
            previous_number = t
        else
            if t < previous_number
                passing = false
                break
            else
                previous_number = t
            end
        end
    end

    passing = doubles_check(target) if passing == true

    count += 1 if passing == true
end

puts count
# 677 for part 2