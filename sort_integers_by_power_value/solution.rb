# @param {Integer} lo
# @param {Integer} hi
# @param {Integer} k
# @return {Integer}
# given an integer returns it's power value
def int_to_power_value(x)
  current_int = x
  power_value = 0
  while current_int > 1 do
    power_value += 1
    if current_int % 2 == 0
      current_int = current_int / 2
    else
      current_int = (3 * current_int) + 1
    end
  end
  return power_value
end

def get_kth(lo, hi, k)
  ints_with_power = (lo..hi).to_a.map do |x|
    [x, int_to_power_value(x)]
  end
  #puts ints_with_power.inspect
  sorted_ints = ints_with_power.sort do |a, b|
    a_val, a_power = a
    b_val, b_power = b
    next -1 if a_power < b_power
    next 1 if a_power > b_power
    # the powers are equal, devolve to the value itself
    a_val <=> b_val
  end
  #puts sorted_ints.inspect
  sorted_ints[k-1][0]
end


puts get_kth(12, 15, 2)
puts get_kth(7, 11, 4)
puts get_kth(10, 20, 5)
puts get_kth(1, 1000, 777)