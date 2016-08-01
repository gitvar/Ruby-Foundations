require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'car'

class CarTest < MiniTest::Test

  def setup
    @car = Car.new
  end

# 1.
  def test_car_exists
    assert(@car)
  end

# 2.
  def test_wheels
    assert_equal(4, @car.wheels)
  end

# 3.
  def test_name_is_nil
    assert_nil(@car.name)
  end

# 4.
  def test_instance_of_car
    assert_instance_of(Car, @car)
  end

# 5.
  def test_includes_car
    array = (1..5).to_a
    array << @car
    assert_includes(array, @car)
  end

  # Refutions: Opposite of Assertions!

# 6.
  def test_doors
    assert_equal(4, @car.doors)
  end

# 7.
  def test_sunroof
    # skip("Bogus Message: Skip this test until the ROJ module is completed.")
    assert_equal(true, @car.sun_roof)
  end

# 8.
  def test_raise_initialize_with_arg
    assert_raises(ArgumentError) do
      car = Car.new(name: "Joey")
    end
  end
end
