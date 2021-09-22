class Card
  attr_reader :point

  @@card_point = {
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "10" => 10,
    "J" => 10,
    "Q" => 10,
    "K" => 10,
    "A" => 1
  }

  def initialize(mark, number)
    @mark = mark
    @number = number
    @point = @@card_point.fetch(@number)
  end

  def ace?
    @number if @number == "A"
  end

  def card_info
    "#{@mark} #{@number}"
  end
end
