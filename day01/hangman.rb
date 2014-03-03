dictionary = []
command_line_args = ARGV.shift
amount_of_guesses_allowed = 6

def read_dictionary(dictionary, command_line_args)
  if command_line_args
    IO.foreach(command_line_args) { |word| dictionary << word.chomp.downcase }
  else
    IO.foreach("/usr/share/dict/words") { |word| dictionary << word.chomp.downcase }
  end
end

read_dictionary(dictionary, command_line_args)
chosen_word = dictionary.sample
correct_guesses = []
winner = nil
bad_guesses = []
chosen_letters = chosen_word.split(//)

amount_of_guesses_total = 0

puts "Welcome to Hangman!"
puts "You have #{amount_of_guesses_allowed} guesses left."
puts "_" * chosen_letters.length
print "> "
letter_guess = gets.chomp

until winner || amount_of_guesses_allowed == 0 do
  if chosen_letters.any? { |letter| letter == letter_guess }
    correct_guesses << letter_guess
    correct_guesses.uniq!
    letter_guess = ""
    amount_of_guesses_total = amount_of_guesses_total + 1
  else
    puts "Sorry, that letter does not exist in the word."
    bad_guesses << letter_guess
    letter_guess = ""
    amount_of_guesses_allowed = amount_of_guesses_allowed - 1
    amount_of_guesses_total = amount_of_guesses_total + 1
  end

  if chosen_letters.sort.uniq == correct_guesses.sort.uniq
    winner = true
    puts "Congratulations! You have guessed the word #{chosen_word} correctly in only #{amount_of_guesses_total} guesses."
    break
  elsif amount_of_guesses_allowed == 0
    puts "Sorry, you have no guesses left. Game over. The word was #{chosen_word}"
    break
  end

  puts "You have #{amount_of_guesses_allowed} guesses left."
  print "You have already guessed these letters: "
  bad_guesses.sort.uniq.each { |letter| print letter }

  puts
  chosen_letters.each do |letter|
    if correct_guesses.include? letter
      print letter
    else
      print "_"
    end
  end
  puts

  print "> "
  letter_guess = gets.chomp
end
