require_relative "character"

class Player < Character

  attr_reader :money, :bet

  INITIAL_MONEY = 10_000
  GAME_RESULT_WIN = 1
  GAME_RESULT_LOSE = 0

  def initialize
    @money = INITIAL_MONEY
  end

  def reset
    super
    @game_result = nil
  end

  def decide_bet
    gets.chomp.to_i
  end

  def bet_money(bet)
    @money -= bet
  end

  def select_action
    gets.chomp.to_i
  end

  def set_win
    @game_result = GAME_RESULT_WIN
  end

  def set_lose
    @game_result = GAME_RESULT_LOSE
  end

  def win?
    @game_result == GAME_RESULT_WIN
  end

  def lose?
    @game_result = GAME_RESULT_LOSE
  end

  def settle(dividend)
    @money += dividend
  end
end
