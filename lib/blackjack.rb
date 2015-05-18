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
    @winner = ""
    @user_hit = true
  end

  def start
    # A pleasant greeting for all who enter
    opener
    sleep(0.5)
    opener2
    sleep(0.5)
    opener
    sleep(0.5)
    opener2
    sleep(0.5)
    opener

    # User is player one, initial draw is two cards
    p1_card = @deck.draw # Draw card
    @p1.add_to_hand(p1_card) # Add card to hand
    @p1_hand_score += p1_card.card_worth #Add card worth to hand score
    player_one_hand_draw # Draws one card, adds to hand & score, and displays to console

    # Dealer is player two, initial draw is two cards
    p2_card = @deck.draw # Draw card
    @p2.add_to_hand(p2_card) # Add card to hand
    @p2_hand_score += p2_card.card_worth #Add card worth to hand score
    player_two_hand_draw # Draws one card, adds to hand & score, and displays to console

    did_anyone_win

    while @winner == "" #contiue to play until there is a winner

      if @user_hit #only asker user once to hit
        @user_hit = check_if_user_will_hit?
      end

      if @user_hit
        display_p2_hand(@p2.hand)
        did_anyone_win
      end

      break if @winner != ""

      if @p2_hand_score < 16
        check_p2_hand(@p2_hand_score) # dealer will take card if hand score less than 16
        did_anyone_win
      end

      break if @winner != ""

      did_anyone_win

      break if @winner != ""

      # if user didn't hit and dealer is done hitting
      player_and_dealer_done_hitting
    end # while loop

    display_winner
  end # start method

  def opener
    system ('clear')
    puts ""
    puts "Welcome to Blackjack!"
    puts "---------------------"
    puts ""
  end

  def opener2
    system ('clear')
    puts ""
    puts "WELCOME to BLACKJACK!"
    puts "====================="
    puts ""
  end

  def player_one_hand_draw
    p1_card = @deck.draw
    @p1.add_to_hand(p1_card) #add card to player's hand
    @p1_hand_score += p1_card.card_worth #add card value to current round
    display_p1_hand(@p1.hand, @p1_hand_score)#display cards & score
  end

  def player_two_hand_draw
    p2_card = @deck.draw
    @p2.add_to_hand(p2_card) #add card to player's hand
    @p2_hand_score += p2_card.card_worth #add card value to current round
    display_p2_hand(@p2.hand) #display only first card in player's hand
  end

  def display_p1_hand(hand, score) # display player's entire hand
    hand.each {|card| card.display_card}
    puts ""
    puts "Your current hand value: #{score}"
    puts ""
  end

  def display_p2_hand(hand) #display only dealer's first hand
    puts "---Dealer's Hand Below---"
    hand[0].display_card # dealer's top card will show
    hand[1].display_card # dealer's 2nd card will show
    puts ""
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
    answer = gets.chomp.downcase
    puts ""
    return answer
  end

  def check_if_user_will_hit?
    choice = false
    hit_user = more_cards
    if hit_user == 'y'
      player_one_hand_draw
      choice = true
    end
    return choice
  end

  def display_winner
    if @winner == @p1.name
      puts ""
      puts "Congrats to #{@winner}! You won with #{@p1_hand_score} points!"
      puts "Dealer count: #{@p2_hand_score}"
      puts "Good Bye"
    elsif @winner == @p2.name
      puts ""
      puts "Looks like #{@winner} won with #{@p2_hand_score} points."
      puts "#{@p1.name} : #{@p1_hand_score} points"
      puts "Good Bye"
    end
  end

  def did_anyone_win
    if @p1_hand_score == 21 && @p2_hand_score < 21 || @p2_hand_score > 21
      @winner = @p1.name #user wins
    elsif @p1_hand_score == 21 && @p2_hand_score == 21
      @winner = @p2.name #comp wins in a tie
    elsif @p1_hand_score > 21
      @winner = @p2.name #comp wins
    elsif  @p1_hand_score < 21
      if @p2_hand_score == 21
        @winner = @p2.name #comp wins
      elsif @p2_hand_score > 21
        @winner = @p2.name #user wins
      end # Inner cond #1 sibling's child
    end # Outer cond  #1 sibling
  end # did anyone win method

    def player_and_dealer_done_hitting
      if !@user_hit && @p2_hand_score >= 16
          if @p1_hand_score > @p2_hand_score && @p1_hand_score < 22
            @winner = @p1.name
          elsif @p2_hand_score > @p1_hand_score && @p2_hand_score < 22
            @winner = @p2.name
          end # Inner cond #2 sibling's child
        end # Outer cond #2 sibling
  end # player & dealer done hitting method
end

