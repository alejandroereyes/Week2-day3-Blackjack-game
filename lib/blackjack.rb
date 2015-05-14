require_relative 'card'
require_relative 'deck'
require_relative 'player'

class Game

  def initialize
    @p1 = Player.new("Human Player") #Player One
    @p2 = Player.new("Dealer - Hal") #Player Two
    @deck = Deck.new
    @p1_hand_score = 0
    @p2_hand_score = 0
    @p1_score = 0
    @p2_score = 0
    @p1_total_score = 0
    @p2_total_score = 0
    @winner = ""
    @user_hit = true
  end

  def start
    # A pleasant greeting for all who enter
    opener

    # User is player one, initial draw is two cards
    p1_card = @deck.draw
    @p1.add_to_hand(p1_card)
    @p1_hand_score += p1_card.card_worth
    player_one_hand_draw

    # Computer is player two, initial draw is two cards
    p2_card = @deck.draw
    @p2.add_to_hand(p2_card)
    @p2_hand_score += p2_card.card_worth
    player_two_hand_draw

    #While loop while user gets cards
    while @user_hit

      # Check if anyone is over 21
      if @p1_hand_score > 21 || @p2_hand_score > 21
        @winner = @p2.name
        puts "#{@winner} wins! You went over!"
        @user_hit = false
      elsif @p1_hand_score > 21 && @p2_hand_score <= 21
        @p2_total_score += 1
        @winner = @p2.name
        puts "#{@winner} wins! with #{@p2_hand_score} points!"
        @user_hit = false
      elsif @p1_hand_score <= 21 && @p2_hand_score > 21
        @p1_total_score += 1
        @winner = @p1.name
        puts "#{@winner} wins!"
        @user_hit = false
      # check if anyone hit 21
      elsif @p1_hand_score == 21
        @p1_total_score += 1
        @winner = @p1.name
        puts "#{@winner} wins!"
        @user_hit = false
      elsif @p2_hand_score == 21
        @p2_total_score += 1
        @winner = @p2.name
        puts "#{@winner} wins! with #{@p2_hand_score} points!"
        @user_hit = false
      end

      # Continue game if no one has won
      if @p1_hand_score < 21 && @p2_hand_score < 21

        # Hal will take another card if his value is less than 16
        check_p2_hand(@p2_hand_score)

        # User will decide to hit or not
        @user_hit = check_if_user_will_hit

        if !@user_hit && @p1_hand_score <= 16 || @p1_hand_score <= @p2_hand_score
          @p2_total_score += 1
          @winner = @p2.name
          puts "#{@winner} wins! with #{@p2_hand_score} points!"
        else
          @p1_total_score += 1
          @winner = @p1.name
          puts "#{@winner} wins!"
        end
      end
    end
  end

  def opener
    puts ""
    puts "Welcome to Blackjack!"
    puts "---------------------"
    puts ""
  end

  def player_one_hand_draw
    #Player One will draw
    p1_card = @deck.draw
    @p1.add_to_hand(p1_card) #add card to player's hand
    @p1_hand_score += p1_card.card_worth #add card value to current round
    display_p1_hand(@p1.hand, @p1_hand_score)#display cards & score
  end

  def player_two_hand_draw
    #Player Two will draw
    p2_card = @deck.draw
    @p2.add_to_hand(p2_card) #add card to player's hand
    @p2_hand_score += p2_card.card_worth #add card value to current round
    display_p2_hand(@p2.hand) #display only first card in player's hand
  end

  def display_p1_hand(hand, score)
    hand.each {|card| card.display_card}
    puts "Your current hand value: #{score}"
    puts ""
  end

  def display_p2_hand(hand)
    puts "---Dealer's Hand Below---"
    hand[0].display_card
  end

  def check_p2_hand(p2_score)
    if p2_score < 16
      p2_card = @deck.draw
      @p2.add_to_hand(p2_card)
      @p2_hand_score += p2_card.card_worth
    end
  end

  def more_cards
    print "Do you want to hit (y/n)? :"
    choice = gets.chomp.downcase
  end

  def check_if_user_will_hit
    choice = false
    hit_user = more_cards
    if hit_user == 'y'
      player_one_hand_draw
      choice = true
    end
    return choice
  end
end

