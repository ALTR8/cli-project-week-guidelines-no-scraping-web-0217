require 'json'
require 'pry'


class CLI < Format

  def run
    self.welcome
    self.delay_print
    self.city_level

  end

  def get_user_input
    @user_input = gets.chomp.downcase
  end

  def welcome
    self.lines
    self.indent("Welcome to the Weather app")
    self.lines
  end

  def city_level
    puts "Please enter a location by address and state"
    puts "or by city and country."
    puts "Other available commands: 'help' 'exit'"
    self.get_user_input
      if @user_input == 'help'
        self.delay_print
        self.help_meta
      elsif @user_input == 'exit'
        self.delay_print
        self.exit
      else
        puts "Searching!"
        self.delay_print
        self.weather_level(self.fetch_data, false)
      end
  end

  def weather_level(loc_object, seen)
    if seen == false
      puts "It looks like you've entered #{loc_object.formatted_address}"
      puts "If that's not what you want, type 'restart' to enter again"
      puts "Otherwise hit any other key"
      self.get_user_input
        if @user_input == "restart"
          self.city_level
        else
        end
    else
      puts "Location: #{loc_object.formatted_address}"
    end

    puts "Please enter one of the following commands:"
    puts "Temperature = 'T' , Windspeed = 'W', Weather = 'S'"
    puts "Other available commands: 'help' 'exit' 'restart'"
    self.get_user_input
      if @user_input == 'help'
        self.delay_print
        self.help_micro(loc_object)
      elsif @user_input == 'exit'
        self.delay_print
        self.exit
      elsif @user_input == "restart"
        self.run
      else
        self.weather_data_presenter(@user_input, loc_object)
      end
  end

  def fetch_data
    new_api = API.new(@user_input)
    new_api.googe_api_fetch
    user_city = new_api.format_city
  end

  def help_meta
    puts "Please enter an address or city. Try to be specific."
    puts "If you enter an address, please write street, city."
    puts "If you enter a city, please write in format city, country"
    puts "Press any key to start again"
    gets.chomp
    self.delay_print
    self.city_level
  end

  def help_micro(city)
    puts "Please enter a command to see data for #{city.name}"
    puts "Temperature in Farenheit = 'T' , Windspeed in MPH = 'W', Weather Summary = 'S'"
  end

  def weather_data_presenter(input, location)
    if input == "t"
      self.delay_print
      puts "The current temperature in #{location.formatted_address}"
      puts "is #{location.temperature} degrees Fahrenheit."
      puts "hit any key to continue"
      gets.chomp
      self.delay_print
      self.weather_level(location, true)
    elsif input == "w"
      self.delay_print
      puts "The current windspeed in #{location.formatted_address}"
      puts "is #{location.wind_speed} MPH."
      puts "hit any key to continue"
      gets.chomp
      self.delay_print
      self.weather_level(location, true)
    elsif input == "s"
      self.delay_print
      puts "Overall, current conditions in #{location.formatted_address}"
      puts "are #{location.summary}"
      puts "hit any key to continue"
      gets.chomp
      self.delay_print
      self.weather_level(location, true)
    else
      puts "Please enter a valid command"
      self.weather_level(location, true)
    end

  end

  def exit
    puts "Goodbye!"
  end

end
