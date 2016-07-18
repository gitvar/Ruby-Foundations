# puts [1, 2, 3, 4, 5].select { |n| n.odd? }

def select(array)
  index = 0
  new_array = []

  while index < array.size
    new_array << array[index] if yield(array[index])
    index += 1
  end

  new_array
end

array = [1, 2, 3, 4, 5]
p select(array) { |n| n.odd? }
puts
p select(array) { |n| puts n }
puts
p select(array) { |n| n + 1 }
