# [1, 2, 3, 4].reduce do |acc, num|
#   acc + num
# end

def reduce(array, acc = 0)

  array.each do |element|
    acc = yield(acc, element)
  end

  acc
end

array = [1, 2, 3, 4, 5]

puts reduce(array) { |acc, num| acc + num }             # => 15
puts reduce(array, 10) { |acc, num| acc + num }         # => 25
puts reduce(array) { |acc, num| acc + num if num.odd? } # => NoMethodError:
