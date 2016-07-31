def call_me(chunk)
  chunk.yield
end

name = "John"
proc1 = Proc.new {puts "Hi, my name is #{name}." }

name = "Louis"

call_me(proc1)
