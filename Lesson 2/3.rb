fib = [ 0, 1 ]
i, x = 1, 1
until x > 100
  fib << x
  i += 1
  x = fib[i] + fib[i-1]
end
puts fib 