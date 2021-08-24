require_relative 'deck.rb'

class Player
  attr_accessor :balance

  def initialize(deck)
    @balance = 100
  end
 
  def win
    @balance += 20
  end

  def draw
    @balance += 10
  end  
end