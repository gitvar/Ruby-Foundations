def test(&block) # Saving the block into a variable!!!
  puts "What's &block_var #{block}?"
  yield
  block.call
end

test { puts "This is the proc!" }

# Output:
# What's &block_var #<Proc:0x007fb339069d90@ex5_proc.rb:7>?
# This is the proc!
# This is the proc!

#
# NOTE:
# If you ever see a method definition with a & in front of the parameter, just remember that this is saving the block into a variable. You can invoke the block with the call method (example: block.call instead of yielding), or you can pass this block into another method.
