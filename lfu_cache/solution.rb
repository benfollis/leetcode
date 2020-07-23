class CacheNode
  attr_accessor :key, :freq_bucket, :value
end

class FreqBucketNode
  attr_accessor :next, :prev, :elements, :count

end
class LFUCache
=begin
    :type capacity: Integer
=end
  def initialize(capacity)
    #puts "Creating cache with capacity #{capacity}"
    @capacity = capacity
    @freq_bucket_head = nil
    @cache = {}
  end

  def remove_bucket_from_list(bucket, next_bucket)
    if bucket != @freq_bucket_head
      bucket.prev.next = next_bucket
      next_bucket && next_bucket.prev = bucket.prev
    else
      next_bucket && next_bucket.prev = nil
      @freq_bucket_head = next_bucket
    end
  end


  def increment_use_count(node)
    current_bucket = node.freq_bucket
    next_bucket = current_bucket.next
    # note this delete is linear in size of elemens. so
    # the algorithm isn't truly 0(n). We'd need to replace this with a
    # linked list and hash table implementation to make it really o(n)
    current_bucket.elements = current_bucket.elements.reject {|elem| node.key == elem.key}
    new_count = current_bucket.count + 1
    #puts "node #{node.key} new count #{new_count}"
    # see if I have to make a new bucket with just this, or ust add myself to next bucket,
    if next_bucket && next_bucket.count == new_count
        next_bucket.elements << node
        node.freq_bucket = next_bucket
    else
      new_bucket = FreqBucketNode.new
      new_bucket.count = new_count
      new_bucket.elements = [node]
      node.freq_bucket = new_bucket
      next_bucket && new_bucket.next = next_bucket
      next_bucket = new_bucket # set up for the fix up of head below
    end
    if current_bucket.elements.empty?
      remove_bucket_from_list(current_bucket, next_bucket)
    else
      current_bucket.next = next_bucket
      next_bucket.prev = current_bucket
    end
  end
=begin
    :type key: Integer
    :rtype: Integer
=end
  def get(key)
    node = @cache[key]
    if node
      increment_use_count(node)
      #puts "#{key} is #{node.value}"
      node.value
    else
      #puts "#{key} not found"
      -1
    end
  end


=begin
    :type key: Integer
    :type value: Integer
    :rtype: Void
=end
  def put(key, value)
    if @capacity < 1
      return nil
    end
    stored = @cache[key]
    if stored
      stored.value = value
      increment_use_count(stored)
    else
      # first eject the head entry if we're going to over our capacity
      if @cache.size == @capacity
        to_evict = @freq_bucket_head.elements.shift
        #puts "evicting #{to_evict.key} with count #{@freq_bucket_head.count}"
        @cache.delete(to_evict.key)
        if @freq_bucket_head.elements.empty?
          remove_bucket_from_list(@freq_bucket_head, @freq_bucket_head.next)
        end
      end
      node = CacheNode.new()
      node.value = value
      node.key = key
      @cache[key] = node
      #puts "node #{key} count 1"
      if @freq_bucket_head && @freq_bucket_head.count == 1
        @freq_bucket_head.elements << node
      else
        new_bucket = FreqBucketNode.new()
        new_bucket.elements = [node]
        new_bucket.count = 1
        if @freq_bucket_head
          new_bucket.next = @freq_bucket_head
          @freq_bucket_head.prev = new_bucket
        end
        @freq_bucket_head = new_bucket
      end
      node.freq_bucket = @freq_bucket_head #always the lowsst one on the totem pole
    end
    nil
  end
end

command_sequence = ["LFUCache","put","put","put","put","put","get","put","get","get","put","get","put","put","put","get","put","get","get","get","get","put","put","get","get","get","put","put","get","put","get","put","get","get","get","put","put","put","get","put","get","get","put","put","get","put","put","put","put","get","put","put","get","put","put","get","put","put","put","put","put","get","put","put","get","put","get","get","get","put","get","get","put","put","put","put","get","put","put","put","put","get","get","get","put","put","put","get","put","put","put","get","put","put","put","get","get","get","put","put","put","put","get","put","put","put","put","put","put","put"]
command_values = [[10],[10,13],[3,17],[6,11],[10,5],[9,10],[13],[2,19],[2],[3],[5,25],[8],[9,22],[5,5],[1,30],[11],[9,12],[7],[5],[8],[9],[4,30],[9,3],[9],[10],[10],[6,14],[3,1],[3],[10,11],[8],[2,14],[1],[5],[4],[11,4],[12,24],[5,18],[13],[7,23],[8],[12],[3,27],[2,12],[5],[2,9],[13,4],[8,18],[1,7],[6],[9,29],[8,21],[5],[6,30],[1,12],[10],[4,15],[7,22],[11,26],[8,17],[9,29],[5],[3,4],[11,30],[12],[4,29],[3],[9],[6],[3,4],[1],[10],[3,29],[10,28],[1,20],[11,13],[3],[3,12],[3,8],[10,9],[3,26],[8],[7],[5],[13,17],[2,27],[11,15],[12],[9,19],[2,15],[3,16],[1],[12,17],[9,1],[6,19],[4],[5],[5],[8,1],[11,7],[5,2],[9,28],[1],[2,2],[7,4],[4,22],[7,24],[9,26],[13,28],[11,26]]
expected = [-1, 19, 17, -1, -1, -1, 5, -1, 12, 3, 5, 5, 1, -1, 30, 5, 30, -1, -1, 24, 18, 14, 18, 11, 18, -1, 4, 29, 30, 12, 11, 29, 17, -1, 18, -1, 20, 29, 18, 18, 20]
output = []
cache = nil
command_sequence.each_with_index do |command, index|
  command_value = command_values[index]
  case command
  when "LFUCache"
    cache = LFUCache.new(command_value[0])
  when "put"
    #puts "putting #{command_value[0]}"
    cache.put(command_value[0], command_value[1])
  when "get"
    #puts "getting #{command_value[0]}"
    output << cache.get(command_value[0])
  end
end

#puts expected.inspect
#puts output.inspect