puts "Введите первое число"
a = gets.to_f

puts "Введите второе число"
b = gets.to_f

puts "Введите третье число"
c = gets.to_f

d = b**2 - 4 * a * c

if d < 0
	puts "Корней нет"
elsif d == 0
	x = (b * -1 + Math.sqrt(d)) / (2 * a)
	puts "Один корень - #{x}"
elsif d > 0
	x = (b * -1 + Math.sqrt(d)) / (2 * a)
	y = (b * -1 - Math.sqrt(d)) / (2 * a)
	puts "Корни - #{x} и  #{y}"
end