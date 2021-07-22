letters = [ 'a', 'e', 'i', 'o', 'u', 'y' ]
x, hash, counter = 0, {}, 1

('a'..'z').each do |i|
  if i == letters[x]
    hash[letters[x]] = counter
    x += 1
  end
  counter += 1
end
puts hash