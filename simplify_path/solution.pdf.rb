# @param {String} path
# @return {String}
def simplify_path(path)
  stack = []
  chunks = path.split('/')
  chunks.each do |chunk|
    if chunk == ".."
      stack.pop
      next
    end
    next if chunk.empty?
    next if chunk == "."
    stack << chunk
  end
  "/#{stack.join('/')}"
end

puts simplify_path("/home/")
puts simplify_path("/../")
puts simplify_path("/home//foo/")
puts simplify_path("/a/./b/../../c/")