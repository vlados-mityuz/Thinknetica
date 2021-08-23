module Hand
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
  end

  module InstanceMethods
    attr_reader :all_cards
    @@all_cards = []

    def create_cards
      @values = ['A', 'K', 'Q', 'J', 10, 9, 8, 7, 6, 5, 4, 3, 2]
      @colors = ['+', '<3', '^', '<>']
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
  end
end