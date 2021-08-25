class Interface
  def players_name
    puts 'Введите ваше имя:'
    @player_name = gets.chomp
  end

  def wanna_continue
    puts 'Хотите продолжить? Введите, 1 если да'
    gets.to_i
  end

  def dealer_won
    puts 'Дилер победил в игре'
  end

  def player_won
    puts 'Игрок победил в игре'
  end

  def turns_interface(player, dealer)
    player_cards(player)
    print "Карты дилера:"
    puts "*" * dealer.players_hand.length
    puts "Выберите ход:\n1. Пропустить\n2. Добавить карту\n3. Открыть карты"
    gets.to_i
  end

  def player_cards(player)
    puts "Карты #{@player_name}: #{player.hand_for_show}, очки: #{player.total_count}"
  end

  def dealer_cards(dealer)
    puts "Карты дилера: #{dealer.hand_for_show}, очки: #{dealer.total_count}"
  end

  def draw
    puts "Ничья"
  end

  def player_win
    puts "#{@player_name} выиграл"
  end

  def dealer_win
    puts "Дилер выиграл"
  end

  def show_balance(dealer_balance, player_balance)
    puts "Баланс #{@player_name}: #{player_balance.balance}\nБаланс дилера: #{dealer_balance.balance}"
  end
end