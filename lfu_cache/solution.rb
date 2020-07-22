class LFUCache

=begin
    :type capacity: Integer
=end
  def initialize(capacity)
    @capacity
    @op_count = 0
    @access_times = {}
    @access_counts = {}
    @cache = {}
  end


=begin
    :type key: Integer
    :rtype: Integer
=end
  def get(key)
    if @cache[key]
      @access_counts[key] = @access_counts[key] + 1
      @access_times[key] = @op_count
      @op_count += 1
      @cache[key]
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
    if @cache_key
      @access_counts[key] = @access_counts[key] + 1
      @access_times[key] = @op_count
    end
    if @cache.size == capacity
      @ac
    end
    @op_count+=1
  end


end

# Your LFUCache object will be instantiated and called as such:
# obj = LFUCache.new(capacity)
# param_1 = obj.get(key)
# obj.put(key, value)
