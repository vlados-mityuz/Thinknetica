class Card
  attr_reader :values, :colors
  
  def initialize
    @values = ['A', 'K', 'Q', 'J', 10, 9, 8, 7, 6, 5, 4, 3, 2]
    @colors = ['♧', '♡', '♢', '♤']
  end
end