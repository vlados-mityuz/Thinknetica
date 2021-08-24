module Hand
  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    attr_reader :all_cards, :total_count, :players_hand

    @@all_cards = []

    private

    def create_cards
      @values = ['A', 'K', 'Q', 'J', 10, 9, 8, 7, 6, 5, 4, 3, 2]
      @colors = ['♧', '♡', '♢', '♤']
      @values.each do |value|
        @colors.each do |color|
          @@all_cards << "#{value}#{color}"
        end
      end
    end

    def point_count
      @total_count = 0
      @players_hand.each do |card|
        @total_count += case card[0...-1]
                        when 'A'
                          if @total_count <= 10
                            11
                          else
                            1
                          end
                        when 'K', 'Q', 'J'
                          10
                        else
                          (card[0...-1]).to_i
                        end
      end
    end

    def add_card_to_hand
      chosen_card = @@all_cards[rand(@@all_cards.length)]
      @@all_cards.delete(chosen_card)
      @players_hand << chosen_card
    end
  end
end
