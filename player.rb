require_relative "character"

class Player < Character

  attr_reader :money, :bet

  INITIAL_MONEY = 10_000

  def initialize
    @money = INITIAL_MONEY
  end

  def decide_bet
    gets.chomp.to_i
  end

  def bet_money(bet)
    @money -= bet
    
  end
end
