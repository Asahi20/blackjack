module Rule

  BLACKJACK_NUM = 21
  ADJUST_NUM = 10
  BLACKJACK_HAND_CARDS_SIZE = 2
  STATUS_BLACKJACK = 0
  STATUS_BUST = 1
  STOP_DRAWING_NUM = 17

  RATE_BLACKJACK = 2.5
  RATE_NOMARL_WIN = 2
  RATE_TIE = 1
  RATE_LOSE = 0

  def adjustable?(point)
    point + ADJUST_NUM <= BLACKJACK_NUM
  end

  def blackjack_conditions?(point, hand_cards)
    point == BLACKJACK_NUM && hand_cards.size == BLACKJACK_HAND_CARDS_SIZE
  end

  def bust_conditions?(point)
    point > BLACKJACK_NUM
  end

  def continue_drawing_conditions?(dealer)
    dealer.point < STOP_DRAWING_NUM
  end

  def calculate_dividend(player, bet)
    rate =
      if player.win? && player.blackjack?
        RATE_BLACKJACK
      elsif player.win? && !player.blackjack?
        RATE_NOMARL_WIN
      elsif !player.win? && !player.lose?
        RATE_TIE
      elsif player.lose?
        RATE_LOSE
      end
    (bet * rate).floor
  end
end
