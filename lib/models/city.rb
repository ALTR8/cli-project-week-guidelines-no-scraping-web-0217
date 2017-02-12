class Location

  attr_reader :name
  attr_accessor :weather_data, :location_name, :street_number, :road, :state, :city, :country, :lat, :lng, :formatted_address

  @@locations = []

  def initialize(location_name)
    @name = location_name
    @@locations << self
  end

  def temperature
    @weather_data["currently"]["temperature"]
  end

  def wind_speed
    @weather_data["currently"]["windSpeed"]
  end

  def summary
    @weather_data["currently"]["summary"]
  end

  def self.locations
    @@locations
  end

  def self.add_city
    @@locations << self
  end

end

class Format
  def lines
    puts "-"* 50
  end

  def arrow
    "----> "
  end

  def delay_search
    [".", ".", ":", ":", "I", "I", "O", "O", "X", "X", 'o', "."].each {|c| putc c ; sleep 0.2}
    puts ""
  end

  def delay_print
    [". " , ". " , ". " , ". " , ". " , ". " , ". " , ].each_with_index {|c, i|  puts " " * i + c ; sleep 0.04}
    [". " , ". " , ". " , ". " , ". " , ". " , ". " , ].each_with_index {|c, i| puts "  " * (i + 4) + c ; sleep 0.02}
    [". " , ". " , ". " , ". " , ". " , ". " , ". " , ". " , ". " , ". " , ". "  ].each_with_index {|c, i| puts "   " * (i + 8) + c; sleep 0.005}
    [". " , ". " , ". " , ". " , ". " , ". " , ". " , ". " , ". " , ". " , ". "  ].each_with_index {|c, i| puts "   " * (i + 9) + c; sleep 0.003}
    [". " , ". " , ". " , ". " , ". " , ". " , ". " , ". " , ". " , ". " , ". "  ].each_with_index {|c, i| puts "   " * (i + 10) + c; sleep 0.001}
    puts ""
  end

  def simple
    [". " , ". " , ". " , ". " ].each_with_index {|c, i|  puts c; sleep 0.04}
  end

  def medium_print
    ["          ............" , "          ............", "          ............"  ].each_with_index {|c, i|  puts c ; sleep 0.04}
  end

  def indent(string)
    puts (' ' * 10) + string
  end

  def clear_screen
    print "\e[2J\e[f"
  end
end
