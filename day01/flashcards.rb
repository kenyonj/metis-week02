class Card
  attr_reader :front, :back
  def initialize(front, back)
    @front = front
    @back = back
  end

  def correct_guess?(guess)
    guess.downcase == @back.downcase
  end
end

class Deck
  attr_reader :cards
  def initialize(filename)
    @cards = []
    file = File.open(filename, "r")
    card_count = file.gets.to_i
    card_count.times do
      front = file.gets.strip
      back = file.gets.strip
      @cards << Card.new(front, back)
    end
  end
end

class Game
  def initialize(deck)
    @deck = deck
  end
  def play
    puts "Welcome to my flashcard app!"
    puts "-" * 28
    @deck.cards.each do |card|
      puts "Guess the answer to #{card.front}"
      correct_guess = false

      3.times do
        print "> "
        guess = gets.strip

        if card.correct_guess?(guess)
          correct_guess = true
          break
        end
      end

      if correct_guess
        puts "You are correct!"
      else
        puts "Sorry, it was actually #{card.back}."
      end
    end
  end
end

deck = Deck.new("decks")
game = Game.new(deck)
game.play
