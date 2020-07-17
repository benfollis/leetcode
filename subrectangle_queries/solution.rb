class SubrectangleQueries

=begin
    :type rectangle: Integer[][]
=end
  def initialize(rectangle)
    @rectangle = rectangle
  end


=begin
    :type row1: Integer
    :type col1: Integer
    :type row2: Integer
    :type col2: Integer
    :type new_value: Integer
    :rtype: Void
=end
  def update_subrectangle(row1, col1, row2, col2, new_value)
    (row1..row2).each do |row|
      (col1..col2).each do |col|
        @rectangle[row][col] = new_value
      end
    end
  end


=begin
    :type row: Integer
    :type col: Integer
    :rtype: Integer
=end
  def get_value(row, col)
    @rectangle[row][col]
  end


end

# Your SubrectangleQueries object will be instantiated and called as such:
# obj = SubrectangleQueries.new(rectangle)
# obj.update_subrectangle(row1, col1, row2, col2, new_value)
# param_2 = obj.get_value(row, col)
#
srq = SubrectangleQueries.new([[1,2,1],[4,3,4],[3,2,1],[1,1,1]])
puts srq.get_value(0,2)
srq.update_subrectangle(0,0,3,2,5)
puts srq.get_value(0,2)
puts srq.get_value(3,1)
srq.update_subrectangle(3,0,3,2,10)
puts srq.get_value(3,1)
puts srq.get_value(0,2)


