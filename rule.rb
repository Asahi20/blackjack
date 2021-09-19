module Rule

  BLACKJACK_NUM = 21
  ADJUST_NUM = 10
  BLACKJACK_HAND_CARD_SIZE = 2
  STATUS_BLACKJACK = 0
  STATUS_BUST = 1

  def adjustable?(point)
    point + ADJUST_NUM <= BLACKJACK_NUM
  end

  def blackjack_condition?(point, hand_cards)
    point == BLACKJACK_NUM && hand_cards.size == BLACKJACK_HAND_CARD_SIZE
  end

  def bust_condition?(point)
    point > BLACKJACK_NUM
  end

end
