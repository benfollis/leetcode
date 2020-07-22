# @param {String} s
# @param {Integer} k
# @return {String}
@digit = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

def decode_at_index(s, k)
  contents = []
  s.each_char do |char|
    if @digit.include? char
      contents = contents * char.to_i
    else
      contents << char
    end
    if contents.length >= k
      return contents[k-1]
    end
  end
  return contents[contents.size-1]
end

puts decode_at_index("leet2code3", 10)
puts decode_at_index("ha22", 5)
puts decode_at_index("a2345678999999999999999", 1)

def build_stack(s)
  stack = []
  current_sequence_len = 0
  s.each_char do |char|
    if @digit.include? char
      current_sequence_len = current_sequence_len * char.to_i
      stack << { :type => :digit, :len => current_sequence_len, :digit=>char}
    else
      current_sequence_len +=1
      stack << { :type => :char, :len=> current_sequence_len, :char => char}
    end
  end
  stack
end

def decode_at_index(s, k)
  stack = build_stack(s)
#  puts stack.inspect
  until(stack.empty?)
    e = stack.pop
    #   puts e.inspect, k
    len = e[:len]
    type = e[:type]
    k = k % len if k > len
    return e[:char] if e[:type] == :char && (k == len || k==0) # k == 0 means return the first char you find since it must be the end of the repetitive sequences
  end
end

#puts decode_at_index("leet2code3", 10)
#puts decode_at_index("ha22", 5)
#puts decode_at_index("a2345678999999999999999", 1)
#puts decode_at_index("a26", 6)
#puts decode_at_index("abc4", 10)
