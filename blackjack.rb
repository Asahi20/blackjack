
require_relative "message"
require_relative "deck"

class Blackjack

  include Message

  def initialize(dealer, player)
    @dealer = dealer
    @player = player
  end

  def start
    start_msg
    @deck = Deck.new
  end

end
