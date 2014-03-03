class Hangman
  MAX_GUESSES = 6
  attr_reader :word, :guesses

  def initialize(word)
    @word = word
    @guesses = []
  end

  def play
    display_welcome_message

    until game_over?
      display_status
      ask_for_letter
    end

    display_result
  end

  private

  def display_result
    if winner?
      puts "You win!"
    else
      puts "You lose! The word was #{word.join}."
    end
  end

  def ask_for_letter
    print "> "
    guesses << gets.strip.downcase
    guesses.uniq!
  end

  def game_over?
    winner? || loser?
  end

  def winner?
    (word - guesses).empty?
  end

  def loser?
    guesses_remaining == 0
  end

  def display_status
    display_turns_remaining
    display_guesses
    display_board
  end

  def display_guesses
    puts guesses.sort.join(" ")
  end

  def display_turns_remaining
    puts "#{guesses_remaining} guesses remaining"
  end

  def display_board
    word.each do |letter|
      if guesses.include? letter
        print "#{letter} "
      else
        print "_ "
      end
    end
    puts
  end

  def guesses_remaining
    MAX_GUESSES - incorrect_guesses
  end

  def incorrect_guesses
    (guesses - word).length
  end

  def display_welcome_message
    puts "Welcome to Hangman!"
  end
end

dictionary = []

file = File.open("/usr/share/dict/words", "r")
dictionary = file.to_a
word = dictionary.sample.strip.split("")

game = Hangman.new(word)
game.play
