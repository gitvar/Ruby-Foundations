def echo_with_yield(str)
  print str
  yield
end

echo_with_yield("Hello, ") { puts "World!" }
