require_relative 'card.rb'

class Deck
  attr_reader :all_cards, :players_hand

  @@all_cards = []

  def initialize
    @cards = Card.new
    create_cards
  end

  def create_cards
    @cards.values.each do |value|
      @cards.colors.each do |color|
        @@all_cards << "#{value}#{color}"
      end
    end
  end

  def add_card_to_hand(players_hand)
    chosen_card = @@all_cards[rand(@@all_cards.length)]
    @@all_cards.delete(chosen_card)
    players_hand << chosen_card
  end
end