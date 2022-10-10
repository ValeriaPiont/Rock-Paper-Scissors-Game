BRACKETS = { '(' => ')',
             '{' => '}',
             '[' => ']'
}

OPENED_BRACKETS = BRACKETS.keys
CLOSED_BRACKETS = BRACKETS.values

def valid?(input)
  stack = []
  input.each_char do |symbol|
    if CLOSED_BRACKETS.include?(symbol)
      if symbol != BRACKETS[stack.last]
        return false
      else
        stack.pop
      end
    elsif OPENED_BRACKETS.include?(symbol)
      stack.push(symbol)
    end
  end
  stack.empty?
end

string = ""
while true
  puts "Enter bracket:"
  user_input = STDIN.gets.chomp
  result = valid?(string.concat(user_input))
  puts result ? "valid" : "invalid"
  puts "Current string: " + string
end