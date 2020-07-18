# @param {String} str
# @return {Integer}
def my_atoi(str)
  whitespace_removed = str.lstrip
  return 0 if whitespace_removed.empty?
  first_char = whitespace_removed[0]
  is_plus_minus = ["+", "-"].include?(first_char)
  return 0 unless is_plus_minus || is_digit(first_char)
  is_minus = "-" == first_char
  whitespace_removed = whitespace_removed.slice(1, whitespace_removed.length) if is_plus_minus
  digits = read_digits(whitespace_removed)
  # drop leading 0s
  while(digits[0] == 0)
    digits.shift
  end
  digits.reverse!
  output = 0
  digits.each_with_index do |digit, base|
    output += (digit * (10**base))
  end
  output = (output * -1) if is_minus
  return (2 ** 31 - 1) if output > (2 ** 31 - 1)
  return (-2 ** 31) if output < -2 ** 31
  output
end

def read_digits(string)
  digits = []
  string.each_char do |char|
    digit = char_to_digit(char)
    return digits unless digit
    digits << digit
  end
  digits
end


def char_to_digit(c)
  map = {"1" => 1, "2" => 2, "3" => 3, "4" => 4, "5" => 5,
         "6" => 6, "7" => 7, "8" => 8, "9" => 9, "0" => 0
  }
  map[c]
end

def is_digit(c)
  char_to_digit(c)
end

#puts my_atoi("42")
#puts my_atoi("   -42")
#puts my_atoi("words and 987")
#puts my_atoi("4193 with words")
#puts my_atoi("-91283472332")
puts my_atoi("  0000000000012345678")