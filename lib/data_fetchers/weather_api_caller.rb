require 'rest-client'
require 'json'
require 'pry'

class API

  attr_reader :url, :weather_data, :CLI
  attr_accessor :city_name

  def initialize(array)#out put of output_array will come here
    @url = array[0]
    @city_name = array[1]
    @weather_data = JSON.parse(RestClient.get(url))
  end

  def new_city
    City.new(@city_name, @weather_data)
  end



end
