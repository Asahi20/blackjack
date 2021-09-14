
require_relative "dealer"
require_relative "player"
require_relative "blackjack"


dealer = Dealer.new
player = Player.new

blackjack = Blackjack.new(dealer, player)
blackjack.start
