
ALPHABET = ('a'..'z').to_a

def convert_to_number(symbol)
  number = ALPHABET.index(symbol)
  if number == nil
    return symbol
  end
  number.to_i + 1
end

puts("Enter word: ")
user_answer = STDIN.gets.chomp

symbols = user_answer.downcase.split("")

symbols = symbols.map { |symbol| convert_to_number(symbol)}

puts "Result: " + symbols.join.to_s
