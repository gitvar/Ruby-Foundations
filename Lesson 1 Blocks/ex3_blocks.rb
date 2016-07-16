def compare(str)
  puts "Before: #{str}"
  after = yield(str)
  puts "After: #{after}"
end

compare("hi") { |word| word.upcase }
puts
compare('hello') { |word| word.slice(word.length-3..word.length) }
puts
compare('hello') { |word| puts "hi" }
puts
puts "This is nil: #{nil}"
