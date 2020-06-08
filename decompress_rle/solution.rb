# @param {Integer[]} nums
# @return {Integer[]}
def decompress_rl_elist(nums)
  target = []
  index = 0
  while index < nums.size-1 do
    len, val = nums[index], nums[index+1]
    index += 2
    len.times do ||
      target << val
    end
  end
  return target
end

nums = [1,2,3,4]
result = decompress_rl_elist(nums)
puts result.inspect