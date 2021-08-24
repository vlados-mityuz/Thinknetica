require_relative 'player'
require_relative 'deck'
require_relative 'card'
require_relative 'hand'

class Controller
  def turns
    loop do
      turns_interface
      case @choice
      when 1
        dealers_turn
      when 2
        @player.add_card
        dealers_turn
        break
      when 3
        dealers_turn
        break
      end
      break if @player.players_hand.length == 3
    end
  end

  def turns_interface
    puts "Ваши карты: #{@player.players_hand}, очки: #{@player.total_count}"
    print "Карты дилера:"
    puts "*" * @dealer.players_hand.length
    puts "Выберите ход:\n1. Пропустить\n2. Добавить карту\n3. Открыть карты"
    @choice = gets.to_i
  end

  def dealers_turn
    @dealer.add_card if @dealer.total_count < 17 && @dealer.players_hand.length < 3
  end

  def winner_count
    puts "Карты #{@player_name}: #{@player.players_hand}, очки: #{@player.total_count}"
    puts "Карты дилера: #{@dealer.players_hand}, очки: #{@dealer.total_count}"
    if @player.total_count == @dealer.total_count
      puts 'Ничья'
      @dealer_balance.draw
      @player_balance.draw
    elsif @player.total_count > 21
      puts 'Дилер выиграл'
      @dealer_balance.win
    elsif @dealer.total_count > 21
      puts "#{@player_name} выиграл"
      @player_balance.win
    elsif @player.total_count == 21
      puts "#{@player_name} выиграл"
      @player_balance.win
    elsif @player.total_count > @dealer.total_count
      puts "#{@player_name} выиграл"
      @player_balance.win
    elsif @player.total_count < @dealer.total_count
      puts 'Дилер выиграл'
      @dealer_balance.win
    end
    puts "Баланс #{@player_name}: #{@player_balance.balance}\nБаланс дилера: #{@dealer_balance.balance}"
  end

  def game
    deck = Deck.new
    @dealer_balance = Player.new(deck)
    @player_balance = Player.new(deck)
    loop do
      deck = Deck.new
      @player_balance.balance -= 10
      @dealer_balance.balance -= 10
      @player = Hand.new(deck)
      @dealer = Hand.new(deck)
      turns
      winner_count
      if @dealer_balance.balance.zero?
        puts 'Игрок победил'
        break
      elsif @player_balance.balance.zero?
        puts 'Дилер победил'
        break
      end
    end
  end

  def menu
    get_name
    loop do
      game
      puts 'Хотите продолжить? Введите, 1 если да'
      continue = gets.to_i
      break if continue != 1
    end
  end

  def get_name
    puts 'Введите ваше имя:'
    @player_name = gets.chomp
  end
end

controller = Controller.new
controller.menu
