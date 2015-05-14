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

    did_anyone_win

    while @winner == ""
      @user_hit = check_if_user_will_hit

      if @user_hit
        puts "Your current hand value: #{@p1_hand_score}"
        display_p2_hand(@p2.hand)
        did_anyone_win
      end

      break if @winner != ""

      if @p2_hand_score < 16
        p2_card = @deck.draw
        @p2.add_to_hand(p2_card) #add card to player's hand
        @p2_hand_score += p2_card.card_worth #add card value to current round
        did_anyone_win
      end

      break if @winner != ""

      did_anyone_win

      break if @winner != ""

      if !@user_hit && @p2_hand_score >= 16
        if @p1_hand_score > @p2_hand_score && @p1_hand_score < 22
          @winner = @p1.name
        elsif @p2_hand_score > @p1_hand_score && @p2_hand_score < 22
          @winner = @p2.name
        end
      end
    end

    if @winner = @p1.name
      puts "Congrats to #{@winner}! You won!"
      puts "Dealer count: #{@p2_hand_score}"
      puts "Good Bye"
    else
      puts "Looks like #{@winner} won with #{@p2_hand_score} points."
      puts "Good Bye"
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

  def did_anyone_win
    if @p1_hand_score == 21
      @winner = @p1.name #user wins
    elsif @p1_hand_score > 21
      @winner = @p2.name #comp wins
    else #user is < 21
      if @p2_hand_score == 21
        @winner = @p2.name #comp wins
      elsif @p2_hand_score > 21
        @winner = @p2.name #user wins
      end
    end
  end
end

