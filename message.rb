module Message
  def start_msg
    puts <<~TEXT
    ----------------------------------
    |                                |
    |           BLACK JACK           |
    |                                |
    ----------------------------------

    TEXT
  end

  def request_bet_msg(player)
    puts <<~TEXT

      現在の所持金は#{player.money}円です。
      掛け金を入力して下さい。

    TEXT
  end

  def info_bet_money_msg(bet, player)
    puts <<~TEXT

      -------- money_information -------

      掛け金： #{bet}円

      現在の所持金 ： #{player.money}円

      ----------------------------------

    TEXT
  end

  def error_msg_for_bet_money
    puts <<~TEXT

      ---------------------------------------------------------
      error ： 1以上，かつ所持金以下の数値を入力してください。
      ---------------------------------------------------------

    TEXT
  end
end
