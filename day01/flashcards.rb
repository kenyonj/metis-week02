require "./deck"
require "./game"

deck = Deck.new("decks")
game = Game.new(deck)
game.play
