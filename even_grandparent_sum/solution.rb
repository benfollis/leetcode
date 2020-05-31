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
def sum_even_grandparent(root)
  return sum_children(root, false)
end


def sum_children(root, evenParent)
  return 0 if root.nil?
  left = root.left
  right = root.right
  sum = 0
  imEven = root.val % 2 == 0
  leftChildVal = (left && left.val) || 0
  rightChildVal = (right && right.val) || 0
  if evenParent
    sum = sum + leftChildVal + rightChildVal
  end
  return sum + sum_children(left, imEven) + sum_children(right, imEven)
end


