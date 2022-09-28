
HANGMAN = [
"----|
|
|
|
|
|
",
"
----|
|   o
|
|
|
|
",
  "
----|
|   o
|   |
|
|
|
",
  "
----|
|   o
|   |\\
|
|
|
",
  "
----|
|   o
|  /|\\
|
|
|
",
  "
----|
|   o
|  /|\\
|    \\
|
|
",
  "
----|
|   o
|  /|\\
|  / \\
|
|"
]

max_wrong_choices = HANGMAN.length
WORDS = %w[autumn cat]

word = WORDS[rand(WORDS.length)]

visible_word = '_' * word.length
wrong_choices = 0
used_letters = []

while wrong_choices < max_wrong_choices && visible_word != word
  puts(HANGMAN[wrong_choices])

  puts("Used letters:")
  puts(used_letters.to_s)
  puts("Current result:")
  puts(visible_word)

  puts("Enter letter")
  user_answer = STDIN.gets.chomp

  while used_letters.include?(user_answer)
    puts("The letter already used. Enter letter again")
    user_answer = STDIN.gets.chomp
  end

  used_letters.push(user_answer)

  is_exist = false

  word.split("").each_with_index do |letter, index|
          if user_answer == letter
            visible_word[index] = user_answer
            is_exist = true
          end
  end

  if is_exist
    puts("->You guessed it<-")
  else
    puts("->+1 step to be hanged<-")
    wrong_choices += 1
  end

end

if wrong_choices == max_wrong_choices
  puts("You were hanged. Word: ")
  puts(word)
elsif
  puts("You won")
end