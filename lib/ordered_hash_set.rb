class InsertionOrderedHash
  class LinkedSetNode
    attr_accessor :prev, :next, :value, :key
  end

  def initialize
    super
    @hash = {}
    @head = nil
    @tail = nil
  end

  def []=(key, value)
    current = @hash[key]
    if current
      current.value = value
    else
      node = LinkedSetNode.new()
      node.prev = @tail
      @tail && @tail.next = node
      node.key = key
      node.value = value
      @tail = node
      @hash[key] = node
      @head = node unless @head
    end
  end

  def [](key)
    current = @hash[key]
    current && current.value
  end

  def delete(key)
    current = @hash[key]
    if current
      current.prev && current.prev.next = current.next
      current.next && current.next.prev = current.prev
    end
    unless current.prev # if we were head
      @head = current.next
    end
    unless current.next # if we were tail
      @tail = current.prev
    end
  end

  def pop()
    current = @head
    return nil unless current
    delete(current.key)
    current.value
  end
end



# tests
table = InsertionOrderedHash.new()
10.times {|x| table[x]=x }
10.times{ |x| raise "No match" unless table.pop == x}