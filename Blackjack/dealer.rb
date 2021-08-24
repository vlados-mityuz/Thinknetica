require_relative 'hand.rb'

class Dealer
  include Hand
  attr_reader :card_counter

  def initialize
    @total_count = 0
    @players_hand = []
    add_card_to_hand
    add_card_to_hand
    point_count
    puts "Карты дилера: **"
  end

  def add_card
    add_card_to_hand
    puts "Карты дилера: ***"
  end

end