class CacheListNode
  attr_accessor :prev, :next, :val, :key
end
class LRUCache
=begin
    :type capacity: Integer
=end
  def initialize(capacity)
    @capacity = capacity
    @list_head = nil
    @list_tail = nil
    @node_map = {}
  end


  def clip_node_from_list(node)
    node.prev && node.prev.next = node.next
    if node.next.nil?
      #If we're the oldest, then set the next oldest to the oldest
      @list_tail = node.prev
    else
      node.next.prev = node.prev
    end
  end

  def insert_node_at_head(node)
    if @list_head
      node.next = @list_head
      @list_head.prev = node
      @list_head = node
    else
      @list_head = node
    end
  end

=begin
    :type key: Integer
    :rtype: Integer
=end
  def get(key)
    node = @node_map[key]
    if node
      # clip us out of the chain
      clip_node_from_list(node)
      insert_node_at_head(node)
      node.val
    else
      -1
    end
  end


=begin
    :type key: Integer
    :type value: Integer
    :rtype: Void
=end
  def put(key, value)
    stored = @node_map[key]
    if stored
      stored.val = value
      #reusing the ips
      get(key)
      nil
    else
      node = CacheListNode.new()
      node.val = value
      node.key = key
      insert_node_at_head(node)
      @list_tail = node unless @list_tail
      @node_map[key] = node
      if @node_map.size > @capacity
        @node_map.delete(@list_tail.key)
        clip_node_from_list(@list_tail)
      end
      nil
    end
  end
end

# Your LRUCache object will be instantiated and called as such:
# obj = LFUCache.new(capacity)
# param_1 = obj.get(key)
# obj.put(key, value)
cache = LFUCache.new(3)
puts cache.get(:x)
cache.put(:x, 1)
cache.put(:x, 3)
cache.put(:y, 3)
cache.put(:x, 2)
cache.get(:y)
cache.get(:y)
cache.get(:y)
cache.get(:y)
cache.get(:y)
cache.put(:z, 3)
cache.put(:x, 1)
cache.put(:a, 2)
puts cache.get(:x)
puts cache.get(:y)
puts cache.get(:z)
puts cache.get(:a)