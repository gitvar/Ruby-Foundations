def compare(str)
  puts "Before: #{str}"
  after = yield(str)
  puts "After: #{after}"
  after
end

compare("hi") { |word| word.upcase }
compare('hello') { |word| word.slice(word.length-3..word.length) }
