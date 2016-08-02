class Car
  attr_accessor :wheels, :sun_roof, :doors, :automatic, :name

  def initialize(name = nil)
    @wheels = 4
    @sun_roof = true
    @doors = 4
    @automatic = true
    @name = name
  end

  def ==(other_car)
    other_car.is_a?(Car) && name == other_car.name
  end
end
