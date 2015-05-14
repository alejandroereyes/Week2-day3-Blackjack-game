class Deck

def initialize
    @cards = Array.new
    suits = [:hearts, :diamonds, :clubs, :spades]
    suits.each do |suit|
      (2..10).each do |value|
        @cards.push(Card.new(suit, value))
      end
      @cards.push(Card.new(suit, "J")) #J
      @cards.push(Card.new(suit, "Q")) #Q
      @cards.push(Card.new(suit, "K")) #K
      @cards.push(Card.new(suit, "A")) #A
    end
    @cards = @cards.shuffle
end

  def draw
    @cards.pop
  end

  def count
    @cards.count
  end
end
