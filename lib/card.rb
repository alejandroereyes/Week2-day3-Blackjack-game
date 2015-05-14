class Card
  attr_reader :suit, :value, :card_worth

  def initialize(suit, value)
    @suit = suit
    @value = value
    @card_worth = blackjack_value
  end

  def display_card
    puts "
     ___________
    |           |
    | #{suit}     |
    | #{value}         |
    |___________|"
  end

  def blackjack_value
    case value
    when "J" then 10
    when "Q" then 10
    when "K" then 10
    when "A" then 11
    else
      value
    end
  end
end
