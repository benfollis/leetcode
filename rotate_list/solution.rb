# Definition for singly-linked list.
class ListNode
     attr_accessor :val, :next
     def initialize(val = 0, _next = nil)
         @val = val
         @next = _next
     end
 end
# @param {ListNode} head
# @param {Integer} k
# @return {ListNode}
def rotate_right(head, k)
  return head unless head

  # size the array so that k <= length of list
  nodes = 0
  current_head = head
  while current_head
    nodes +=1
    current_head = current_head.next
  end

  k = k % nodes
  return head if k == 0
  #ring buf for the last k + 1 nodes (the amount to shift, plush the one we need to change pinter on)
  current_head = head
  buf = []
  node_count = 0
  until current_head.nil?
    buf << current_head
    buf.shift if buf.size > (k + 1)
    current_head = current_head.next
    node_count+=1
  end
#  puts buf.inspect
  buf[0].next = nil # contains the k-1th last node
  k = k % node_count if k > node_count
  buf[k].next = head
  return buf[1]
end

def array_to_list(arr)
  head = nil
  prev = nil
  arr.each do |num|
    node = ListNode.new(num)
    head = node unless head
    prev.next = node if prev
    prev = node
  end
  head
end

def list_to_arr(head)
  output = []
  while head
    output << head.val
    head = head.next
  end
  output
end

list = array_to_list([1,2,3,4,5])
#puts list.inspect
#puts list_to_arr(list).inspect
rotated = rotate_right(list, 2)
#puts rotated.inspect
puts list_to_arr(rotated).inspect

list = array_to_list([0,1,2])
rotated = rotate_right(list, 4)
puts list_to_arr(rotated).inspect
puts list_to_arr(rotate_right(array_to_list([1]), 0)).inspect