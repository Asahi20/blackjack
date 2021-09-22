
require_relative "character"

class Dealer < Character
  def draw_card(deck)
    deck.cards.pop
  end
end
