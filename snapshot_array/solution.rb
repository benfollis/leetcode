# problem is to fill in implementation
class SnapshotArray

=begin
    :type length: Integer
=end
  def initialize(length)
    @snapshot_id = 0
    @store = Array.new(length, 0)
    @snapshots = Array.new
  end


=begin
    :type index: Integer
    :type val: Integer
    :rtype: Void
=end
  def set(index, val)
    @store[index] = val
  end


=begin
    :rtype: Integer
=end
  def snap()
    @snapshots << @store.clone
    @snapshot_id += 1
    return @snapshot_id-1;
  end


=begin
    :type index: Integer
    :type snap_id: Integer
    :rtype: Integer
=end
  def get(index, snap_id)
    return @snapshots[snap_id][index]
  end

end

# Your SnapshotArray object will be instantiated and called as such:
# obj = SnapshotArray.new(length)
# obj.set(index, val)
# param_2 = obj.snap()
# param_3 = obj.get(index, snap_id)
snapshotArr = SnapshotArray.new(3); #set the length to be 3
snapshotArr.set(0,5);  # Set array[0] = 5
puts snapshotArr.snap();  # Take a snapshot, return snap_id = 0
snapshotArr.set(0,6)
puts snapshotArr.get(0,0)  # Get the value of array[0] with snap_id = 0, return 5
