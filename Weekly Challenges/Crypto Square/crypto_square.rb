class Crypto

  attr_reader :plain_text

  def initialize(plain_text)
    @plain_text = plain_text
  end

  def normalize_plaintext
    @plain_text.gsub(/[^a-zA-Z0-9]/, '').downcase
  end

  def size
    Math.sqrt(normalize_plaintext.length.to_f).ceil
  end

  def plaintext_segments
    segments = []
    normalized = normalize_plaintext
    until normalized.empty?
      segments << normalized.slice!(0...size)
    end
    segments
  end

  def ciphertext
    cipher_text_array = []
    (0...size).each do |index|
      plaintext_segments.each do |segment|
        cipher_text_array << segment[index]
      end
    end
    cipher_text_array.join
  end

  def normalize_ciphertext
    result = []
    l = plaintext_segments.map(&:length).max
    transposed = plaintext_segments.map(&:chars).map{|e| e.values_at(0...l)}.transpose
    transposed.each { |array| result << array.compact.join}
    result.join(' ')
  end
end

# crypto = Crypto.new('We all know interspecies romance is weird.')
# crypto = Crypto.new('I am.')
# crypto = Crypto.new('Madness, and then illumination.')
# p crypto.plain_text
# p crypto.normalize_plaintext
# p crypto.size
# p crypto.plaintext_segments
# p crypto.ciphertext
# l = crypto.plaintext_segments.map(&:length).max
# p l
# p crypto.plaintext_segments.map(&:chars)
# p crypto.plaintext_segments.map(&:chars).map{|e| e.values_at(0...l)}.transpose
# transposed = crypto.plaintext_segments.map(&:chars).map{|e| e.values_at(0...l)}.transpose
# puts
# result = []
# transposed.each { |array| result << array.compact.join }
# p result
# crypto.normalize_ciphertext


# class Crypto
#   def initialize(text)
#     @text = text
#   end
#
#   def normalize_plaintext
#      @text.gsub(/\W/,'').downcase
#   end
#
#   def size
#     Math.sqrt(normalize_plaintext.length).ceil
#   end
#
#   def plaintext_segments
#     segments = []
#     normalized = normalize_plaintext
#     until normalized.empty?
#       segments << normalized.slice!(0...size)
#     end
#     segments
#   end
#
#   def ciphertext
#     segments = plaintext_segments
#     # ciphered = ''
#     ciphered = []
#     segments.length.times do
#       segments.each do |seg|
#         ciphered << seg.slice!(0)
#         # if seg.empty?
#         #   seg << '*'
#         # end
#       end
#     end
#     # ciphered.delete('*')
#     ciphered.join
#   end
#
#   def normalize_ciphertext
#     result = []
#     l = plaintext_segments.map(&:length).max
#     transposed = plaintext_segments.map(&:chars).map{|e| e.values_at(0...l)}.transpose
#     transposed.each { |array| result << array.compact.join}
#     result.join(' ')
#   end
# end
