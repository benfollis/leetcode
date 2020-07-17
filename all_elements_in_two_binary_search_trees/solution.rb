# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {TreeNode} root1
# @param {TreeNode} root2
# @return {Integer[]}
def get_all_elements(root1, root2)
  # this is o(n) since you can just do
  # two pre-order walk, and then merge the
  # arrays in o(n) time
  # it's also asymptotically optimal since you can't do a walk
  # without visiting all elements at least once.
  # My c is 2 instead of 1 though
  sorted1 = bst_to_array(root1, [])
  sorted2 = bst_to_array(root2, [])
  output = []
  while (!sorted1.empty? || !sorted2.empty?)
    # the three cases
    if sorted1.empty?
      output << sorted2.shift
      next
    end
    if sorted2.empty?
      output << sorted1.shift
      next
    end
    if sorted1[0] < sorted2[0]
      output << sorted1.shift
    else
      output << sorted2.shift
    end
    # the next iteration
  end
  return output
end


def bst_to_array(root, current_array)
  return current_array if root.nil?
  root.left && bst_to_array(root.left, current_array)
  current_array << root.val
  root.right && bst_to_array(root.right, current_array)
  current_array
end