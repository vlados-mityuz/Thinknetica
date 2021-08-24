class Hand
  attr_reader :total_count, :players_hand

  def initialize(deck)
    @deck = deck
    @total_count = 0
    @players_hand = []
    add_card
    add_card
    point_count
  end

  def add_card
    @deck.add_card_to_hand(@players_hand)
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
end