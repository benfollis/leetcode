# Note this os O(n^2). There might be a faster way of doing it if we're careful about things,
# but the problem is that the positions of later elements are shifted by one
# each time we swap in front (And that swap could come from any element before or after the element
# that just shifted)
# @param {Integer[]} queries
# @param {Integer} m
# @return {Integer[]}
def process_queries(queries, m)
  store = (1..m).to_a
  positions = {}
  output = []
  queries.each do |query|
    zero_index = store.find_index(query)
    output << zero_index
    store.delete_at(zero_index)
    store.unshift(query)
  end
  output
end

queries = [3,1,2,1]
m = 5

puts process_queries(queries, m).inspect