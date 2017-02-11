require 'rest-client'
require 'json'
require 'pry'

class API

  attr_reader :location_name, :location_data

  @@cities = []

  def initialize(location_name)
    @location_name = location_name
  end

  def googe_api_fetch
    googe_url = "https://maps.googleapis.com/maps/api/geocode/json?address="
    google_api_key = "&key=AIzaSyCa1oTjGDdo92X0CzBUleXYjh_vtMhnJxY"
    @location_data =  JSON.parse(RestClient.get(googe_url + @location_name + google_api_key))
  end

  def format_city

    #makes a new location object
    new_city = Location.new(@location_name)

    #inputs location data from the google API
    address = @location_data["results"][0]["address_components"]
      address.each do |item|
      i_loc = item["types"]
      if i_loc.include?("street_number")
        new_city.street_number = item["long_name"]
      elsif i_loc.include?("route")
        new_city.road = item["long_name"]
      elsif i_loc.include?("administrative_area_level_1") && i_loc.include?("political")
        new_city.state = item["long_name"]
      elsif i_loc.include?("locality") && i_loc.include?("political")
        new_city.city = item["long_name"]
      elsif i_loc.include?("country") && i_loc.include?("political")
        new_city.country = item["long_name"]
      else
      end
    end

    new_city.lat = lat = @location_data["results"][0]["geometry"]["location"]["lat"]
    new_city.lng = @location_data["results"][0]["geometry"]["location"]["lng"]
    new_city.formatted_address = @location_data["results"][0]["formatted_address"]

    #uses long / lat to find and input weather data from weather API
    weather_url = "https://api.darksky.net/forecast/9445006c42f8a772a4901551f5d79978/"
    output_url = weather_url + new_city.lat.to_s + "," + new_city.lng.to_s
    new_city.weather_data = JSON.parse(RestClient.get(output_url))

    #adds the location to the list of locations
    Location.locations << new_city
    new_city
  end

end
