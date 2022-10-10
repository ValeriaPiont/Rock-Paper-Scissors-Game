BRACKETS = { '(' => ')',
             '{' => '}',
             '[' => ']'
}

OPENED_BRACKETS = BRACKETS.keys
CLOSED_BRACKETS = BRACKETS.values

def balanced?(input)
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

def bracket_valid?(symbol)
   (OPENED_BRACKETS.include? symbol) || (CLOSED_BRACKETS.include? symbol)
end

string = ""
exit_string = "exit"
while true
  puts "Enter bracket:"
  user_input = STDIN.gets.chomp
  if exit_string.eql?(user_input)
    break
  end
  if bracket_valid?(user_input)
    result = balanced?(string.concat(user_input))
    puts result ? "valid" : "invalid"
  else
    puts "Unknown symbol"
    puts "Type 'exit' and press Enter to exit"
  end
  puts "Current string: " + string
end