class MyError < StandardError
  attr_reader :thing
  def initialize(msg="My default message", thing="apple")
    @thing = thing
    super(msg)
  end
end

begin
  raise MyError.new("my message", "my thing")
rescue => e
  puts e.thing # "my thing"
end
