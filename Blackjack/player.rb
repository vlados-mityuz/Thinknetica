require_relative 'hand.rb'

class Player
  include Hand
  attr_reader :balane, :card_counter

  def initialize
    @players_hand = []
    @balance = 100
    create_cards
    @players_hand << give_card
    @players_hand << give_card
  end

end