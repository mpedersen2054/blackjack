require 'pry'

# save players name use it throughout the app
# ask the player if he wants to play again
# save not just the card val, but also the suit
# use multipul decks

def say_card(card)
  suit = card[0]
  card_suit  = "Clubs" if suit == 'C'
  card_suit  = "Spades" if suit == 'S'
  card_suit  = "Diamonds" if suit == 'D'
  card_suit  = "Hearts" if suit == 'H'

  value = card[1]
  card_value = value
  card_value = "Ace" if value == 'A'

  puts "#{card_value} of #{card_suit}"
end

def calculate_total(cards)
  hand = cards.map { |x| x[1] }

  total = 0

  hand.each do |val|
    if val == 'A'
      total += 11
    elsif val.to_i == 0
      total += 10
    else
      total += val.to_i
    end
  end

  hand.select {|x| x == "A"}.count.times do
    if total > 21
      total -= 10
    end
  end
  total
end


suit = ['S', 'H', 'D', 'C']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

deck = suit.product(cards)
deck2 = suit.product(cards)

# concat the each element of 2nd deck into 1st deck
deck2.each do |card|
  deck << card
end

deck.shuffle!

playerhand = []  # players current hand
dealerhand = []  # dealers current hand

playerhand << deck.pop
dealerhand << deck.pop
playerhand << deck.pop
dealerhand << deck.pop

playertotal = calculate_total(playerhand)
dealertotal = calculate_total(dealerhand)

puts "Welcome to blackjack!! And your name is...?"
playername = gets.chomp
puts "Alright... lets play some blackjack #{playername}!"
puts
puts
puts " ---------- dealer deals you 2 cards ----------"
puts "#{playername}'s first card is:"
puts "-------------------"
say_card(playerhand[0])
puts
puts
puts "#{playername}'s second card is:"
puts "--------------------"
say_card(playerhand[1])
puts
puts
puts "#{playername}'s total = #{playertotal}"

if playertotal == 21
  "Congratulations!! You hit 21!! You Win!!"
end

while playertotal < 21
  puts "Would you like to stay, or hit?"
  puts "Enter 'stay' or 'hit' into the console to continue"
  stay_or_hit = gets.chomp

  if stay_or_hit != 'stay' && stay_or_hit != 'hit'
    puts "Please enter 'stay' or 'hit' to continue..."
    next
  end

  if stay_or_hit == 'stay'
    "You chose to stay. Your total is: #{playertotal}... Now its the dealers turn"
    break
  end

  new_card = deck.pop
  puts "#{playername}'s hit card:"
  puts "-------------------"
  say_card(new_card)
  playerhand << new_card
  playertotal = calculate_total(playerhand)
  puts
  puts
  puts "Your new total is: #{playertotal}..."
  puts
  puts

  if playertotal == 21
    puts "Congrats!! You win!! BLACKJACK!!"
    exit
  end

  if playertotal > 21
    puts "Sorry, you busted. Try again."
    exit
  end
end

puts "The dealers first card is:"
puts
say_card(dealerhand[0])
puts
puts "The dealer's second card is:"
say_card(dealerhand[1])
puts

puts "The dealers total is: #{dealertotal}"

if dealertotal == 21
  puts "Dealer hit blackjack. You lose. Sorry..."
end


while dealertotal < 17
  new_card = deck.pop
  puts "The dealers new card is:"
  say_card(new_card)
  dealerhand << new_card
  dealertotal = calculate_total(dealerhand)
  puts "The dealer's total is now: #{dealertotal}"

  if dealertotal == 21
    puts "Dealer hit blackjack, You lose. Sorry..."
    exit
  end

  if dealertotal > 21
    puts "Dealer busted. You Win!!! Congrats!!"
    exit
  end
end

puts "Dealer's cards: "
dealerhand.each do |card|
  puts "--------"
  puts say_card(card)
end
puts "for a total of #{dealertotal}"

puts "Your cards:"
playerhand.each do |card|
  puts "--------"
  puts say_card(card)
end
puts "for a total of #{playertotal}"

if dealertotal > playertotal
  puts "sorry dealer wins"
elsif dealertotal < playertotal
  puts "congrats you win!"
else
  "its a tie"
end
























