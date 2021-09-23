
require_relative "message"
require_relative "deck"
require_relative "rule"

class Blackjack

  HIT_NUM = 1
  STAND_NUM = 2

  include Message
  include Rule

  def initialize(dealer, player)
    @dealer = dealer
    @player = player
  end

  def start
    start_msg
    @deck = Deck.new

    @dealer.reset
    @player.reset

    @bet = request_bet

    deal_first
    start_player_turn unless @player.blackjack?
    start_dealer_turn unless @player.bust?
    judge_winner
    settle_dividend
    game_exit if @player.money == 0
  end

  private

  def request_bet
    request_bet_msg(@player)
    bet = 0
    loop do
      bet = @player.decide_bet
      if bet.between?(1, @player.money)
        @player.bet_money(bet)
        info_bet_money_msg(bet, @player)
        break
      end
      error_msg_for_bet_money
    end
    bet
  end

  def deal_first
    first_deal_msg(@dealer)
    2.times do
      deal_card_to(@player)
      deal_card_to(@dealer)
    end
    show_hand_msg(@dealer, first_time: true)
    show_hand_msg(@player)

    info_status_or_points(@player)
  end

  def deal_card_to(character)
    drawn_card = @dealer.draw_card(@deck)
    character.receive(drawn_card)
  end

  def  info_status_or_points(character)
    if character.blackjack?
      blackjack_msg(character)
    elsif character.bust?
      point_msg(character)
      bust_msg(character)
    else
      point_msg(character)
    end
  end

  def start_player_turn
    loop do
      action_num = request_hit_or_stand

      case action_num
      when STAND_NUM
        player_turn_end_msg(@player)
        break
      when HIT_NUM
        deal_card_to(@player)
        show_hand_msg(@player)
        info_status_or_points(@player)
        break if @player.bust?
      end
    end
  end

  def request_hit_or_stand
    select_action_msg(@player, HIT_NUM, STAND_NUM)
    action_num = 0
    loop do
      action_num = @player.select_action
      break if action_num.between?(HIT_NUM, STAND_NUM)

      error_msg_about_action(HIT_NUM, STAND_NUM)
    end
    action_num
  end

  def start_dealer_turn
    dealers_hand_msg(@dealer)
    show_hand_msg(@dealer)

    info_status_or_points(@dealer)

    return if @player.blackjack?

    type_enter_msg
    $stdin.gets.chomp

    while continue_drawing_conditions?(@dealer)
      dealer_draw_msg(@dealer, STOP_DRAWING_NUM)
      deal_card_to(@dealer)
      show_hand_msg(@dealer)
      info_status_or_points(@dealer)
    end
  end

  def judge_winner
    compare_point_msg

    type_enter_msg
    $stdin.gets.chomp

    show_hand_msg(@player)
    info_status_or_points(@player)

    show_hand_msg(@dealer)
    info_status_or_points(@dealer)

    if @dealer.bust?
      @player.set_win
    elsif @player.bust?
      @player.set_lose
    elsif @dealer.point < @player.point
      @player.set_win
    elsif @player.point < @dealer.point
      @player.set_lose
    else
      judge_winner_when_same_point
    end

    info_judge
  end

  def judge_winner_when_same_point
    if @player.blackjack? && !@dealer.blackjack?
      @player.set_win
    elsif !@player.blackjack? && @dealer.blackjack?
      @player.set_lose
    end
  end

  def info_judge
    if @player.win?
      win_msg(@player)
    elsif @player.lose?
      lose_msg(@player)
    else
      end_in_tie_msg
    end
  end

  def settle_dividend
    type_enter_msg
    $stdin.gets.chomp

    dividend = calculate_dividend(@player, @bet)
    @player.settle(dividend)

    dividend_msg(dividend, @player)
  end

  def game_exit
    info_gameover_msg
    exit
  end
end
