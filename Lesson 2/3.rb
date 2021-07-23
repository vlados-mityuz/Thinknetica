fib = [ 0, 1 ]
number = 1
until number > 100
  fib << number
  number = fib[-1] + fib[-2]
end
puts fib 