class City

  attr_reader :name
  attr_accessor :data

  def initialize(name, data)
    @name = name
    @data = data
  end

  def temperature
    @data["currently"]["temperature"]
  end

  def wind_speed
    @data["currently"]["windSpeed"]
  end

  def summary
    @data["currently"]["summary"]
  end



end
