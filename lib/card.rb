class Card
  attr_reader :suit, :value, :card_worth

  def initialize(suit, value)
    @suit = suit
    @display_suit = check_suit
    @value = value
    @card_worth = blackjack_value
    @display_value = display_value_adj
  end

  def display_card
    print "
     ____________
    |            |
    |  #{@display_suit}   |
    |     #{@display_value}     |
    |____________|"
  end

  def check_suit
    if @suit == :hearts
     return  "♡ ♡ ♡ ♡"
    elsif @suit == :spades
     return "♤ ♤ ♤ ♤"
    elsif @suit == :clubs
     return "♧ ♧ ♧ ♧"
    elsif @suit == :diamonds
      return "♢ ♢ ♢ ♢"
    end
  end

  def display_value_adj
    if @card_worth < 10 || @value == "J" ||  @value == "Q" || @value == "K" || @value == "A"
      return "#{@value} "
    else
      return @value
    end
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
