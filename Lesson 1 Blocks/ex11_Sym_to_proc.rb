ar1 = (1..10).to_a.map(&:to_s).map(&:to_i)
puts ar1.first.class
puts

puts %w(hello world).each(&:upcase!)
puts

puts (1..15).to_a.select(&:odd?)
puts

puts (1..15).to_a.select(&:even?).any?(&:odd?)
puts

puts (1..3).to_a.any?(&:even?)
puts

#
# Symbol to proc:
#
#
# What's the mechanism at work here? Let's break down this code: `(&:to_s)`. First, when we add a `&` in front of an object, it tells Ruby to try to convert this object into a block. To do so, it's expecting a Proc object. If this object is not a Proc object, it will call `to_proc` on the object. So two things are happening:
#
# -   First, Ruby sees if the object after `&` is a Proc. If it's not, it'll try to call `to_proc` on the object, which should return a `Proc` object. If not, this won't work.
#
# -   Then, the `&` will turn the Proc into a block.
#
# Let's pause here and look again at `(&:to_s)`. This means that Ruby is trying to turn `:to_s` into a block, but it's not a Proc, it's a Symbol. Ruby will then try to call the `Symbol#to_proc` method -- and there is one! This method will return a Proc object, which will execute the method based on the name of the symbol.
#
# So in other words, `Symbol#to_proc` will return a Proc, which the `&` will then turn into a block, which turns our shortcut into the long form block usage.

def my_method
  yield(2)
end

# Turns the symbol into a Proc, then & turns the Proc into a block
puts my_method(&:to_s).class         # => "2"
puts my_method(&:to_s)               # => "2"
puts

# The code example below will try to break up the 2 steps.
def my_method
  yield(2)
end

a_proc = :to_s.to_proc          # explicitly call to_proc on the symbol
puts my_method(&a_proc).class
puts my_method(&a_proc)         # convert Proc into block, then pass block in.
