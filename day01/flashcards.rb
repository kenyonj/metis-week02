class Card
  attr_reader :front, :back
  def initialize(front, back)
    @front = front
    @back = back
  end

  def play
    puts "Guess the answer to #{front}"
    correct_guess = false

    3.times do
      print "> "
      guess = gets.strip

      if correct_guess?(guess)
        correct_guess = true
        break
      end
    end

    if correct_guess
      puts "You are correct!"
    else
      puts "Sorry, it was actually #{back}."
    end
  end

  def correct_guess?(guess)
    guess.downcase == back.downcase
  end
end

class Deck
  attr_accessor :cards
  def initialize(filename)
    @cards = []
    file = File.open(filename, "r")
    card_count = file.gets.to_i
    card_count.times do
      front = file.gets.strip
      back = file.gets.strip
      cards << Card.new(front, back)
    end
  end

  def play
    cards.each do |card|
      card.play
    end
  end
end

class Game
  def initialize(deck)
    @deck = deck
  end

  def play
    print_welcome_message
    @deck.play
  end

  private

  def print_welcome_message
    puts "Welcome to my flashcard app!"
    puts "-" * 28
  end
end

deck = Deck.new("decks")
game = Game.new(deck)
game.play
