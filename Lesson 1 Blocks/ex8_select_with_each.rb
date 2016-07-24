# puts [1, 2, 3, 4, 5].select { |n| n.odd? }

def select(array)
  new_array = []

  array.each do |element|
    new_array << element if yield(element)
  end

  new_array
end

array = [1, 2, 3, 4, 5]
p select(array) { |n| n.odd? }
puts
p select(array) { |n| puts n }
puts
p select(array) { |n| n + 1 }
