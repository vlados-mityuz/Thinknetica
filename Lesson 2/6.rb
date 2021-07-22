cart = {}

loop do 
  puts "Введите название товара"
  item = gets.chomp
  if item == "стоп"
    break
  end
  puts "Введите количество"
  quan = gets.to_i
  if cart.include?(item) == false
    puts "Введите стоимость"
    value = gets.to_f
    cart[item] = {quantity: quan, value: value}
  else
    cart[item][:quantity] += quan
  end
end

puts cart
summary = 0
cart.each do |x, y|
  puts "#{x} summary: "
  puts y[:quantity] * y[:value]
  summary += y[:quantity] * y[:value]
end

puts "Summary: #{summary}"