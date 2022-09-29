
ALPHABET = ('a'..'z').to_a

def convert_to_number(symbol)
  index = ALPHABET.index(symbol)
  index + 1 if index
end

def alphabet_position(text)
  symbols = text.downcase.split("")
  symbols = symbols.map { |symbol| convert_to_number(symbol)}
  symbols.compact.join(" ").to_s
end

puts "Enter word: "
user_answer = STDIN.gets.chomp
puts "Result: " + alphabet_position(user_answer)

