# @param {Integer[]} a
# @return {Integer}
require 'set'
# this is correct, but slow
# To make it faster observe that the number of bits in a result can oonly increase by oring in more elements
def subarray_bitwise_o_rs(a)
  result_set = Set.new()
  a.size.times do |i|
    (1..a.size-i).each do |length|
      subarray = a[i, length]
      #puts subarray.inspect
      result = subarray.reduce(0) do |bor, elem|
        bor | elem
      end
      #puts result
      result_set << result
    end
  end
  result_set.size
end


test = [1,2,4]
result = subarray_bitwise_o_rs(test)
puts result.inspect