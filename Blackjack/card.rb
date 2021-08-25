class Card
  attr_reader :value, :color

  VALUES = ['A', 'K', 'Q', 'J', 10, 9, 8, 7, 6, 5, 4, 3, 2]
  COLORS = ['♧', '♡', '♢', '♤']
  
  def initialize(value, color)
    @value = value
    @color = color
  end
end