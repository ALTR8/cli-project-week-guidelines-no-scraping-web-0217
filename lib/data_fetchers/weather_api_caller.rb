require 'rest-client'
require 'json'
require 'pry'

class API

  attr_reader :location_name, :location_data

  @@cities = []
  def initialize(location_name)
    @location_name = location_name
    # @weather_data = JSON.parse(RestClient.get(url))
  end

  def googe_api_fetch
    googe_url = "https://maps.googleapis.com/maps/api/geocode/json?address="
    google_api_key = "&key=AIzaSyCa1oTjGDdo92X0CzBUleXYjh_vtMhnJxY"
    @location_data =  JSON.parse(RestClient.get(googe_url + @location_name + google_api_key))
  end

  def google_api_format_city

    new_city = City.new(@location_name)

    address = @location_data["results"][0]["address_components"]

    address.each do |item|
      if item["types"].include?("street_number")
        new_city.street_number = item["types"]["long_name"]
      elsif item["types"].include?("route")
        new_city.road = item["types"]["long_name"]
      elsif item["types"].include?("administrative_area_level_1", "political")
        new_city.state = item["types"]["long_name"]
      elsif item["types"].include?("locality" && "political")
        new_city.city = item["types"]["long_name"]
      elsif item["types"].include?("country" && "political")
        new_city.country = item["types"]["long_name"]
      else
      end
    end

    new_city.lat = lat = @location_data["results"][0]["geometry"]["location"]["lat"]
    new_city.long = @location_data["results"][0]["geometry"]["location"]["long"]
    new_city.formatted_address = @location_data["results"][0]["formatted_address"]

    
    City.cities << new_city
  end



end

a = API.new("6712 turkey farm")
a.googe_api_lat_long
a.location_data
