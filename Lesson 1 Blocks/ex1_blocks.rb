## Yielding with an argument

# method implementation
def increment(number)
  if block_given?
    yield(number + 1)
  else
    number + 1
  end
end

# method invocation
increment(5) { |num| puts num }
