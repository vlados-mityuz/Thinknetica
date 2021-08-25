require_relative 'player'
require_relative 'deck'
require_relative 'card'
require_relative 'hand'
require_relative 'interface'

class Game
  def initialize(interface)
    @interface = interface
    menu
  end

  def get_name
    @interface.players_name
  end

  def menu
    get_name
    loop do
      game
      continue = @interface.wanna_continue
      break if continue != 1
    end
  end

  def game
    @dealer_balance = Player.new
    @player_balance = Player.new
    loop do
      @deck = Deck.new
      @player_balance.balance -= 10
      @dealer_balance.balance -= 10
      @player = Hand.new
      @dealer = Hand.new
      @player.add_card(@deck)
      @player.add_card(@deck)
      @dealer.add_card(@deck)
      @dealer.add_card(@deck)
      turns
      winner_count
      if @dealer_balance.balance.zero?
        @interface.dealer_won
        break
      elsif @player_balance.balance.zero?
        @interface.player_won
        break
      end
    end
  end

  def turns
    loop do
      choice = @interface.turns_interface(@player, @dealer)
      case choice
      when 1
        dealers_turn
      when 2
        @player.add_card(@deck)
        dealers_turn
        break
      when 3
        dealers_turn
        break
      end
      break if @player.players_hand.length == 3
    end
  end

  def dealers_turn
    @dealer.add_card(@deck) if @dealer.total_count < 17 && @dealer.players_hand.length < 3
  end

  def winner_count
    @interface.player_cards(@player)
    @interface.dealer_cards(@dealer)
    if @player.total_count == @dealer.total_count
      @interface.draw
      @dealer_balance.draw
      @player_balance.draw
    elsif @player.total_count > 21
      @interface.dealer_win
      @dealer_balance.win
    elsif @dealer.total_count > 21
      @interface.player_win
      @player_balance.win
    elsif @player.total_count == 21
      @interface.player_win
      @player_balance.win
    elsif @player.total_count > @dealer.total_count
      @interface.player_win
      @player_balance.win
    elsif @player.total_count < @dealer.total_count
      @interface.dealer_win
      @dealer_balance.win
    end
    @interface.show_balance(@dealer_balance, @player_balance)
  end
end