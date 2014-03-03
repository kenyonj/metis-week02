class Card
  def initialize(front, back)
    @front = front
    @back = back
  end

  def front
    @front
  end

  def back
    @back
  end
end

class Deck
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

puts "Welcome to my flashcard app!"
puts "-" * 28

deck = Deck.new("decks")

deck.each do |card|
  puts "Guess the answer to #{card.front}"
  correct_guess = false

  3.times do
    print "> "
    guess = gets.strip

    if guess.downcase == card.back.downcase
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
