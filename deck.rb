
require_relative "card"

class Deck
  attr_reader :cards

  # カードデッキを作成し、シャッフルまで行う
  def initialize
    # デッキの配列を生成
    @cards = []

    marks = %w(♤ ♡ ♢ ♧)
    numbers = %W(A 2 3 4 5 6 7 8 9 10 J Q K)
    marks.each do |mark|
      numbers.each do |number|
        card = Card.new(mark, number)
        @cards << card
      end
    end
    @cards.shuffle!
  end
end
