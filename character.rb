
require_relative "rule"

class Character
  attr_reader :hand_cards, :point, :point_list

  include Rule

  def reset
    @hand_cards = []
    @status = nil
  end

  def receive(drawn_card)
    @hand_cards << drawn_card
    calc_point
  end

  def blackjack?
    @status == STATUS_BLACKJACK
  end

  def bust?
    @status == STATUS_BUST
  end

  private

  def calc_point
    @point_list = []
    @point_list << @point = @hand_cards.map(&:point).sum
    if ace? && adjustable?(@point)
      @point += ADJUST_NUM
      @point_list.unshift(@point)
    end
    change_status
  end


  def ace?
    @hand_cards.map(&:ace?).any?
  end

  def change_status
    if blackjack_conditions?(@point, @hand_cards)
      @status = STATUS_BLACKJACK
    elsif bust_conditions?(point)
      @status = STATUS_BUST
    end
  end

end
