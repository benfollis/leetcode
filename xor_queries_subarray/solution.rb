#this is a straightforward dynamic problem bottom up computation
# problem
# @param {Integer[]} arr
# @param {Integer[][]} queries
# @return {Integer[]}
def print_matrix(matrix)
  puts "----------"
  matrix.each do |row|
    puts row.inspect
  end
  puts "----------"
end
def xor_queries(arr, queries)
  #the data array data_i_j contians the result of the xor of data[i], data[i+i]...data[j]
  # initialize
  data = Array.new(arr.size){ Array.new(arr.size,0) }
  # for the loop, we'll make arr[i] ^ arra[i] = arr[i]
  # as then we don't drop it from the cumulative,
  # note the problem doesn't really follow xor since arr[x] ^ arr[x] = 0
  # but in the tests they say arr[x] ^ array[x] = arr[x]
  arr.size.times do |x|
    data[x][x] = arr[x]
   end
  #print_matrix(data);

  arr.size.times do |i|
    (i+1..arr.size-1).each do |j|
      # puts "I #{i} J #{j}"
      previous = data[i][j-1] || 0
      data[i][j] = previous ^ arr[j]
        #  print_matrix(data)
    end
  end
  # in true xor def we'd fix up the diagonals
  #arr.size.times {|x| data[x][x] = 0}
  #print_matrix(data)
  return queries.map do |query|
    i, j = query
    data[i][j]
  end
end

arr = [1,3,4,8]
queries = [[0,1],[1,2],[0,3],[3,3]]
puts xor_queries(arr, queries).inspect

arr = [4,8,2,10]
queries = [[2,3],[1,3],[0,0],[0,3]]
puts xor_queries(arr, queries).inspect