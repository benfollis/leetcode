# A word is possible with a bijection if the have
# the characters appear in the same positions and quantity
# so we'll compile a signature, with abstract ints in place of the chars
# then compare the signature of the pattern for the signatur of the word
#
def word_to_signature(word)
  num_encountered_chars = 1
  char_to_symbol_map = {}
  signature = []
  word.each_char do |char|
    if char_to_symbol_map[char].nil?
      char_to_symbol_map[char] = num_encountered_chars
      num_encountered_chars += 1
    end
    symbol = char_to_symbol_map[char]
    signature << symbol
  end
  return signature
end

def find_and_replace_pattern(words, pattern)
  pattern_signature = word_to_signature(pattern)
  matches = words.select do |word|
    word_signature = word_to_signature(word)
    word_signature == pattern_signature
  end
  return matches
end

words = ["abc","deq","mee","aqq","dkd","ccc"]
pattern = "abb"
puts find_and_replace_pattern(words, pattern).inspect