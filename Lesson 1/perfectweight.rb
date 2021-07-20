puts "Как вас зовут?"
name = gets.chomp

puts "Укажите ваш рост"
height = gets.chomp.to_i

result = (height - 110) * 1.15

if result > 0
	puts "#{name}, ваш оптимальный вес - #{result} кг"
else 
	puts "Ваш вес уже оптимальный!"
end