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
