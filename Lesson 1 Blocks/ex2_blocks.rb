# # method implementation
def test
  yield(1, 2)  if block_given? # passing 2 block arguments at block invocation time
end

# method invocation # expecting 1 parameter in block implementation
test { |num| puts num }
# No Error!


# # method invocation # expecting no (zero) parameter in block implementation
# test
# Error! "ex2_blocks.rb:3:in `test': no block given (yield) (LocalJumpError)
# from ex2_blocks.rb:9:in `<main>'"
# If you add the code "if block_given?" then no error results!

puts

# method invocation
test do |num1, num2| # expecting 2 parameters in block implementation
  puts "#{num1}_#{num2}."
end
# No Error!

puts


# method implementation
def test2
  yield(1) # passing 1 block argument at block invocation time
end

# method invocation
test2 do |num1, num2| # expecting 2 parameters in block implementation
  puts "#{num1}_#{num2}."
end
# No Error!
# In this case, num2 block local variable is nil, so the string interpolation converted that to an empty string, which is why we get 1 (there's an extra space).
