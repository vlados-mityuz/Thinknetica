class Hand
  attr_reader :total_count, :players_hand, :hand_for_show

  def initialize
    @players_hand = []
    @hand_for_show = []
  end

  def add_card(deck)
    deck.add_card_to_hand(@players_hand, @hand_for_show)
    point_count
  end

  def point_count
    @total_count = 0
    @players_hand.each do |card|
      value = card.value
      @total_count += case value
                      when 'A'
                        if @total_count <= 10
                          11
                        else
                          1
                        end
                      when 'K', 'Q', 'J'
                        10
                      else
                        value.to_i
                      end
    end
  end
end