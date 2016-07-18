# 5.times { |n| puts n }

def times(number)
  counter = 0
  while counter < number
    yield(counter)
    counter += 1
  end
  number
end

times(5) { |n| puts n }

# This example is made a little bit more complicated due to the while loop, but pay attention to the interplay between the method implementation and the block. From within the method, we are yielding execution to the block, and we are passing an argument to the block. When we call the method, we know that we must include a block that takes an argument.
