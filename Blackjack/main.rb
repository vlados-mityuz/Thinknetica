require_relative 'player'
require_relative 'deck'
require_relative 'card'
require_relative 'hand'
require_relative 'game'
require_relative 'interface'

interface = Interface.new
game = Game.new(interface)
