require_relative 'hand.rb'

class Player
  include Hand
  attr_reader :balane, :card_counter

  def initialize
    @total_count = 0
    @players_hand = []
    @balance = 100
    create_cards
    add_card_to_hand
    add_card_to_hand
    point_count
    puts "Карты: #{@players_hand}, очки: #{@total_count}"
  end

end