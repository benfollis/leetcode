# Stack will be represented by a double linked list.
# The stack will be augmented a hash indexed by value, and containing
# all list nodes that have that value
# when we decide to nuke all nodes with value k, we'll iterate
# the list in the hash, and set node.previous.next = node.next
# thereby shrinking the stack.
# Lastly we'll need a priority queue for popularity of keys,
# which will be a max heap.
#

class DoubleLinkedList
  attr_accessor(:val, :previous, :next)
  def initialize(val)
    @val = val
    @next = nil
    @previous = nil
  end
end
class FreqStack
  def initialize()
    @heap = []
    @sta
  end


=begin
    :type x: Integer
    :rtype: Void
=end
  def push(x)

  end


=begin
    :rtype: Integer
=end
  def pop()

  end


end

# Your FreqStack object will be instantiated and called as such:
# obj = FreqStack.new()
# obj.push(x)
# param_2 = obj.pop()