# We're going to keep two scalars,
# A sum, and the current knowm max depth, for whihc the sum is the sum of the values of
# leaves at that depth. The root is considered depth 0
# When traversing the tree and encountering a leaf, if the current depth is equal to the max known depth
# then we'll add to the sum. If lesser, we'll ignore the leaf, and if greater, we'll
# set the sum to the value of this node.

# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {TreeNode} root
# @return {Integer}
def deepest_leaves_sum(root)
  @max_depth_so_far = 0
  @level_sum = 0
  # the helper just recures the tree and mutates teh depth and level sum
  deepest_leaves_helper(root, 0)
  return @level_sum
end

def deepest_leaves_helper(root, current_depth)
  is_leaf = root.left.nil? && root.right.nil?
  if is_leaf
    if current_depth == @max_depth_so_far
      @level_sum += root.val
    elsif current_depth > @max_depth_so_far
      @level_sum = root.val
      @max_depth_so_far = current_depth
    end
    return
  end
  # not a leaf
  root.left && deepest_leaves_helper(root.left, current_depth + 1)
  root.right && deepest_leaves_helper(root.right, current_depth + 1)
  return
end
