# @param {Integer[]} group_sizes
# @return {Integer[][]}
def group_the_people(group_sizes)
  filled_groups = []
  unfilled_groups = {}
  # loop invariant is that unfilled groups value will contain an array
  # that has current size less than it's hash key, while filled groups
  # will contain all groups which no more people can be allocated to
  #
  # As we progress through the group sizes array, we'll allocate people to
  # unfilled groups

  group_sizes.each_with_index do |group_size, person_id|
    unfilled_group = unfilled_groups[group_size] || [] #we don't have zero size groups, so this is safe
    unfilled_group << person_id
    if unfilled_group.size == group_size then
      # we're full. Move to the filled group, and
      # remove us from unfilled
      filled_groups << unfilled_group
      unfilled_groups.delete(group_size)
    else
      # not full yet, so just store us back
      unfilled_groups[group_size] = unfilled_group
    end
  end
  return filled_groups
end


groupSizes = [3,3,3,3,3,1,3]
result = group_the_people(groupSizes)
puts result.inspect