# [1, 2, 3].each { |n| puts n }

def each(array)
  index = 0
  while index < array.size
    yield(array[index])
    index += 1
  end

  array
end

p each([1, 2, 3]) { |n| puts n }

# NOTE:
# Our each method is solely focused on iterating and not on anything beyond that. Writing a generic iterating method allows method callers to add additional implementation details at method invocation time by passing in a block. This is why when we implemented the method, we yield to the block. Note that the trick here is to pass the current element we're working with to the block. At each iteration within the while loop, execution then goes to the block (with the current element as the block argument), and will return execution back to the while loop after executing the block. 
