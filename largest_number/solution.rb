# the output integer is always of fixed length. Therefore we will
# get the largest output by at any given point chosing the candidate with the largest
# sigificant digit
# @param {Integer[]} nums
# @return {String}
def largest_number(nums)
  strings = nums.map { |num| num.to_s }
  seq_priority = (0..9).to_a.reverse.map { |x| x.to_s }
  sig_digits = strings.reduce({}) do |acc, seq|
    current = acc[seq[0]] || []
    current << seq
    acc[seq[0]] = current
    acc
  end
  output = ''
  seq_priority.each do |digit|
    while (sig_digits[digit])
      list = sig_digits[digit]
      output << list.shift
      if list.empty?
        sig_digits.delete(digit)
      else
        sig_digits[digit] = list
      end
    end
  end
  output
end

#this is broken, we actually need a total ordering on the numbers of the same first digit on the second digit, etc
#
puts largest_number([10,2])
puts largest_number([3,30,34,5,9])