# @param {Integer[][]} grid
# @return {Integer}
def max_increase_keeping_skyline(grid)
  num_rows = grid.size
  num_cols = grid[0].size
  # row is e/w
  row_maxes = Array.new(num_rows, 0)
  # col is n/s
  col_maxes = Array.new(num_cols, 0)
  #first compute the skyline limits e/w n/s
  num_rows.times do |i|
    num_cols.times do |j|
      element = grid[i][j]
      row_maxes[i] = element if row_maxes[i] < element
      col_maxes[j] = element if col_maxes[j] < element
    end
  end
  # now transform the input grid to the limits of the're e/w n/s skyline
  # keeping track of the total increase
  overall_height_increase = 0
  new_grid = Array(num_rows)
  num_rows.times do |i|
    new_grid[i] = []
    num_cols.times do |j|
      element = grid[i][j]
      # a safe increase doesn't go larger than either the e/w or n/s
      new_element = [row_maxes[i], col_maxes[j]].min
      overall_height_increase += new_element - element #this is always non-negative otherwise element would be the max
      new_grid[i] << new_element
    end
  end
  puts new_grid.inspect
  overall_height_increase
end


grid = [[3, 0, 8, 4], [2, 4, 5, 7], [9, 2, 6, 3], [0, 3, 1, 0]]
puts max_increase_keeping_skyline(grid)