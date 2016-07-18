def time_it
  first_timer = Time.now
  yield
  second_timer = Time.now
  puts "It took #{second_timer - first_timer} seconds."
end

time_it { sleep(2) }
puts
time_it { 10.times { puts "Hi there!" } }
