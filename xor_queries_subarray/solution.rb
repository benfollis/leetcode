
def print_matrix(matrix)
  puts "----------"
  matrix.each do |row|
    puts row.inspect
  end
  puts "----------"
end
#this is a straightforward dynamic problem bottom up computation
# problem
# @param {Integer[]} arr
# @param {Integer[][]} queries
# @return {Integer[]}
def xor_queries(arr, queries)
  # each element j in data will contain
  # arr[0] ^ arr[1]... arr[j] (that is the xor of all elements up to j)
  # then any query of i,j can be computed by data[j] ^ data[i]
  data = Array.new(arr.size)
  arr.each_with_index do |elem, index|
    if (index == 0) then
      data[index] = elem
    else
      data[index] = data[index-1] ^ elem
    end
  end
  return queries.map do |query|
    i, j = query
    if i==j then
      #this is fubar x ^ x should be 0
      arr[i]
    elsif i == 0 then
      data[j]
    else
      data[i-1] ^ data[j]
    end
  end
end

arr = [1,3,4,8]
queries = [[0,1],[1,2],[0,3],[3,3]]
puts xor_queries(arr, queries).inspect

arr = [4,8,2,10]
queries = [[2,3],[1,3],[0,0],[0,3]]
puts xor_queries(arr, queries).inspect