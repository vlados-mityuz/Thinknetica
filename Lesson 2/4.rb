letters = [ 'a', 'e', 'i', 'o', 'u', 'y' ]
x = 0
hash = {}
counter = 1

('a'..'z').each do |letter|
  if letter == letters[x]
    hash[letters[x]] = counter
    x += 1
  end
  counter += 1
end
puts hash