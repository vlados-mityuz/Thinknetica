require_relative 'card.rb'

class Deck
  attr_reader :all_cards, :players_hand

  def initialize
    @all_cards = []
    create_cards
  end

  def create_cards
    Card::VALUES.each do |value|
      Card::COLORS.each do |color|
        card = Card.new(value,color)
        @all_cards << card
      end
    end
  end

  def add_card_to_hand(players_hand, hand_for_show)
    chosen_card = @all_cards[rand(@all_cards.length)]
    @all_cards.delete(chosen_card)
    players_hand << chosen_card
    hand_for_show << "#{chosen_card.value}#{chosen_card.color}"
  end
end