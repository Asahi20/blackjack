
require_relative "rule"

class Character
  attr_reader :hand_cards

  include Rule

  def reset
    @hand_cards = []
    @status = nil
  end

  def receive(drawn_card)
    @hand_cards << drawn
  end

end
