puts "Укажите длину первой стороны треугольника"
a = gets.to_f

puts "Укажите длину второй стороны треугольника"
b = gets.to_f

puts "Укажите длину третьей стороны треугольника"
c = gets.to_f

a, b, c = [a, b, c].sort

if a == b && b == c 
	puts "Треугольник равнобедренный и равносторонний"
elsif a == b || b == c
	puts "Треугольник равнобедренный"
elsif a**2 + b**2 == c**2
  puts "Треугольник прямоугольный"
end