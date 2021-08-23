module Hand
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
  end

  module InstanceMethods
    attr_reader :all_cards
    attr_accessor :total_count, :players_hand
    @@all_cards = []

    def create_cards
      @values = ['A', 'K', 'Q', 'J', 10, 9, 8, 7, 6, 5, 4, 3, 2]
      @colors = ['♧', '♡', '♢', '♤']
      @values.each do |value|
        @colors.each do |color|
          @@all_cards << "#{value}#{color}"
        end
      end
    end

    def give_card
      chosen_card = @@all_cards[rand(@@all_cards.length)]
      @@all_cards.delete(chosen_card)
      return chosen_card
    end

    def point_count
      @players_hand.each do |card|
        puts card[0...-1]
        if card[0...-1] == 'A'
          if @total_count <= 10
            @total_count += 11
          else
            @total_count += 1
          end
        elsif card[0...-1] == 'K' || card[0...-1] == 'Q' || card[0...-1] == 'J'
          @total_count += 10
        else
          @total_count += (card[0...-1]).to_i
        end
      end          
    end

    def add_card_to_hand
      @players_hand << give_card
    end
  end
end