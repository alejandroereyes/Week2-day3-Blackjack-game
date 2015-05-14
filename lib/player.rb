class Player
  attr_accessor :name, :deck, :score, :hand, :hand_score

  def initialize(name)
    @name = name
    @score = 0
    @hand = Array.new
    @hand_score = 0
  end

  def add_to_hand(card)
    @hand << card
  end
end

