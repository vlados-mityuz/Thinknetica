require_relative 'hand'
require_relative 'player'

class Controller
  include Hand

  def dealers_turn
    @dealer.add_card if @dealer.total_count < 17 && @dealer.players_hand.length < 3
  end

  def turns
    loop do
      puts "Ваши карты: #{@player.players_hand}, очки: #{@player.total_count}"
      print "Карты дилера:"
      puts "*" * @dealer.players_hand.length
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
      break if @player.players_hand.length == 3
    end
    puts 'Подсчет очков'
  end

  def winner_count
    puts "Карты #{@player_name}: #{@player.players_hand}, очки: #{@player.total_count}"
    puts "Карты дилера: #{@dealer.players_hand}, очки: #{@dealer.total_count}"
    if @player.total_count == @dealer.total_count
      puts 'Ничья'
      @dealer_balance += 10
      @player_balance += 10
    elsif @player.total_count > 21
      puts 'Дилер выиграл'
      @dealer_balance += 20
    elsif @dealer.total_count > 21
      puts "#{@player_name} выиграл"
      @player_balance += 20
    elsif @player.total_count == 21
      puts "#{@player_name} выиграл"
      @player_balance += 20
    elsif @player.total_count > @dealer.total_count
      puts "#{@player_name} выиграл"
      @player_balance += 20
    elsif @player.total_count < @dealer.total_count
      puts 'Дилер выиграл'
      @dealer_balance += 20
    end
    puts "Баланс #{@player_name}: #{@player_balance}\nБаланс дилера: #{@dealer_balance}"
  end

  def menu
    @dealer_balance = 100
    @player_balance = 100
    loop do
      create_cards
      @dealer_balance -= 10
      @player_balance -= 10
      @player = Player.new
      @dealer = Player.new
      turns
      winner_count
      if @dealer_balance.zero?
        puts 'Игрок победил'
        break
      elsif @player_balance.zero?
        puts 'Дилер победил'
        break
      end
    end
  end
end

puts 'Введите ваше имя:'
@player_name = gets.chomp
controller = Controller.new
loop do
  controller.menu
  puts 'Хотите продолжить? Введите, 1 если да'
  continue = gets.to_i
  break if continue != 1
end
