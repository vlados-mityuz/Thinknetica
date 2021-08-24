require_relative 'hand.rb'
require_relative 'dealer.rb'
require_relative 'player.rb'

class Controller
  include Hand

  def dealers_turn
    if @dealer.total_count < 17 && @player.players_hand.length < 3
      @dealer.add_card
    end
  end

  def turns
    loop do
      puts "Выберите ход:\n1. Пропустить\n2. Добавить карту\n3. Открыть карты"
      choice = gets.to_i
      case choice
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
      if @player.players_hand.length == 3
        break
      end
    end
    puts "Подсчет очков"
  end

  def winner_count
    puts "Карты игрока: #{@player.players_hand}, очки: #{@player.total_count}"
    puts "Карты дилера: #{@dealer.players_hand}, очки: #{@dealer.total_count}"
    if @player.total_count == @dealer.total_count
      puts "Ничья"
      @@dealer_balance += 10
      @@player_balance += 10
    elsif @player.total_count > 21
      puts "Дилер выиграл"
      @@dealer_balance += 20
    elsif @player.total_count == 21
      puts "Игрок выиграл"
      @@player_balance += 20
    elsif @player.total_count > @dealer.total_count
      puts "Игрок выиграл"
      @@player_balance += 20
    elsif @player.total_count < @dealer.total_count
      puts "Дилер выиграл"
      @@dealer_balance += 20
    end
    puts "Баланс игрока: #{@@player_balance}\nБаланс дилера: #{@@dealer_balance}"
  end

  def menu
    loop do
      create_cards
      @@dealer_balance -= 10
      @@player_balance -= 10
      @player = Player.new
      @dealer = Dealer.new
      turns
      winner_count
      if @@dealer_balance == 0
        puts 'Игрок победил'
        break
      elsif @@player_balance == 0
        puts 'Дилер победил'
        break
      end
    end
  end
end

puts "Введите ваше имя:"
player_name = gets.chomp
controller = Controller.new
loop do
  controller.menu
  puts 'Хотите продолжить? Введите, 1 если да'
  continue = gets.to_i
  if continue != 1
    break
  end
end