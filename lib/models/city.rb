class City


  attr_reader :name
  attr_accessor :data, :location_name, :street_number, :road, :state, :city, :country, :lat, :long, :formatted_address

  @@cities = []

  def initialize(location_name)
    @name =

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

  def self.cities
    @@cities
  end

  def self.add_city
    @@cities << self
  end

end
