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
def good_nodes(root)
  good_nodes_helper(root, nil)
end

def good_nodes_helper(root, max)
  return 0 if root.nil?
  count = 0
  children_max = max
  if max.nil? || max <= root.val then
    count += 1
    children_max = root.val
  end
  count += good_nodes_helper(root.left, children_max) + good_nodes_helper(root.right, children_max)
  count
end