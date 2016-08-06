class CircularBuffer
  def initialize(length)
    @buffer = []
    @length = length
  end

  def read
    fail BufferEmptyException.new if @buffer.empty?
    @buffer.shift
  end

  def write(obj)
    return if obj.nil?
    fail BufferFullException.new if full?
    @buffer.push(obj)
  end

  def write!(obj)
    return if obj.nil?
    read if full?
    write(obj)
  end

  def clear
    @buffer = []
  end

  def full?
    @buffer.length == @length
  end

  class BufferEmptyException < RuntimeError; end
  class BufferFullException < RuntimeError; end
end
