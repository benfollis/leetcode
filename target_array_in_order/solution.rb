# @param {Integer[]} nums
# @param {Integer[]} index
# @return {Integer[]}
def create_target_array(nums, index)
  target = Array.new(index.size)
  index.each_with_index do |index_val, index_pos|
    puts "Index Pos #{index_pos}, Index val #{index_val}"
    puts "Target: #{target.inspect}"
    if target[index_val].nil?
      target[index_val] = nums[index_pos]
    else
      #make room
      #special case because slice doesn't like negative numbers
      if (index_val == 0) then
        target.unshift(nums[index_pos])
        target.pop
      else
        slice1 = target.slice(0..index_val - 1)
        slice2 = target.slice(index_val..target.size - 1)
        puts "s1#{slice1.inspect}, s2#{slice2.inspect}"
        slice1 << nums[index_pos]
        slice2.pop # we just added a new element
        target = slice1.concat(slice2)
      end
    end
  end
  target
end

#nums = [0,1,2,3,4]
#index = [0,1,2,2,1]
nums = [1, 2, 3, 4, 0]
index = [0, 1, 2, 3, 0]
result = create_target_array(nums, index)
puts result.inspect