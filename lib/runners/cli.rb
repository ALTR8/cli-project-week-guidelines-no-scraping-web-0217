require 'json'
require 'pry'


class CLI

  def run
    shiney = "================================="
    snowy = "********************************"
    puts shiney
    puts snowy
    puts shiney
    puts snowy
    puts shiney
    puts "Welcome to the weather in five specific cities. Why would you want to live anywhere
    else? Please choose New York, Los Angeles, Chicago, Detroit, or New Orleans to explore the
    weather in these beautiful cities."
    puts shiney
    puts snowy
    puts shiney
    puts snowy
    puts shiney

    self.get_user_input

  end

  def get_user_input

    @user_input = gets.chomp.downcase

    if @user_input == "new york" || @user_input == "los angeles" || @user_input == "chicago" || @user_input == "detroit" || @user_input == "new orleans"
      puts "Finding your weather"
      api = API.new(self.url_hash)
      @user_city1 = api.new_city
      self.do_stuff
    elsif @user_input == "exit"
      self.exit
    else
      puts "You can only choose the cities we gave you!"
        self.run
    end
  end

  def url_hash

    city_hash = {
    "new york" => "40.730610,-73.935242",
    "los angeles" => "34.052235,-118.243683",
    "chicago" => "41.881832,-87.623177",
    "detroit" => "42.331429,-83.045753",
    "new orleans" => "29.951065,-90.071533"
  }

    url = "https://api.darksky.net/forecast/9445006c42f8a772a4901551f5d79978/"
    output_url = url + city_hash[@user_input]
    output_array = [output_url, @user_input]
  end

  def do_stuff
    puts "What do you want to know? Temperature, Summary, or Wind speed"
    answer = gets.chomp.downcase
    if answer == "temperature"
      puts @user_city1.temperature
    elsif answer == "summary"
      puts @user_city1.summary
    elsif answer == "wind speed"
      puts @user_city1.wind_speed
    elsif answer == "exit"
      puts "you're done!"
      exit
    else
      puts "We told you your options, stupid!"
      self
    end
  puts "thank you!!!"
  puts "if you would like to exit the app, please type exit, otherwise press enter for more weather data!"
    answer = gets.chomp.downcase
    if answer == "exit"
      self.exit
    else
      self.run
    end
  end

  def exit
    puts "goodbye!"
  end





end
