class CircularBuffer

  class BufferFullException < StandardError; end
  class BufferEmptyException < StandardError; end

  def initialize(size)
    @max_size = size
    @buffer = []
  end

  def full?
    @buffer.size >= @max_size
  end

  def write(element)
    full? ? raise(BufferFullException) : @buffer.push(element).compact!
  end

  def write!(element)
    return if element.nil?
    @buffer.shift if full?
    @buffer << element
  end

  def read
    @buffer.empty? ? raise(BufferEmptyException) : @buffer.shift
  end

  def clear
    @buffer.clear
  end

  def to_s
    p @buffer
  end
end
