require 'json'
require 'pry'


class CLI < Format

  @user_array = []
  @user_input = ''

  def run
    while @user_input != "!exit"
      delay_print
      clear_screen
      welcome
      mode_select
    end
    exit_s
  end

  def welcome
    self.lines
    self.indent("Welcome to the Weather Map")
    self.lines
  end

  def get_user_input
    @user_input = gets.chomp.downcase
    if @user_input == "!help"
      delay_print
      help
    elsif @user_input == "!l"
      delay_print
      listing_mode
    elsif @user_input == "!c"
      delay_print
      comparison_mode
    elsif @user_input== '!exit'
      exit_s
    else
    end
  end

  def mode_select
    lines
    puts "Please enter '!L' for listing mode to list"
    puts "weather details for an individual city or address."
    puts ""
    puts "Please enter '!C' for comparison mode to compare"
    puts "weather details from several locations."
    puts ""
    puts "Other commands : '!exit' and '!help'"
    lines

    get_user_input
  end

  def user_array
    @user_array
  end

  def comparison_mode
    clear_screen
    @user_array = []
    lines
    puts "COMPARISON MODE"
    lines
    puts "Please enter a group of locations to compare."
    puts "Separate them by '!!' "
    puts ""
    puts "Other commands : '!exit' and '!help'"
    lines
    get_user_input

    puts ""
    puts "working..."
    puts ""
    answer_array = @user_input.split("!!")

    answer_array.each do |item|
      @user_array << self.fetch_data(item)
    end

    comparison_presenter
  end

  def listing_mode
      clear_screen
      lines
      puts "LISTING MODE"
      lines
      puts "Please enter a location by address and state"
      puts "or by city and country."
      puts "Other available commands: '!help' '!exit' '!C' for comparison mode"
      lines

      get_user_input

        puts ""
        puts "Working..."
        puts ""

        loc_object = self.fetch_data(@user_input)

        puts "It looks like you've entered #{loc_object.formatted_address}"
        puts "If that's not what you want, type 'restart' to enter again"
        puts "Otherwise hit any other key"

        get_user_input
          if @user_input == "restart"
            listing_mode
          else
          end
        simple
        puts ""
        listing_presenter(loc_object)


  end

  def listing_presenter(loc_object)
      lines
      puts "Location: #{loc_object.formatted_address}"
      lines
      puts "CONDITIONS: #{loc_object.summary}"
      puts "TEMPERATURE: #{loc_object.temperature} degrees Fahrenheit."
      puts "WINDSPEED: #{loc_object.wind_speed} MPH."
      puts "hit any key to continue"
      get_user_input
      medium_print
      listing_mode

  end

  def comparison_presenter

      lines
      puts "Please enter what variable to display:"
      puts "!T : temperature"
      puts "!W : wind speed"
      puts "!S : summary"
      lines

      get_user_input


      if @user_input == "!t"
        graph_maker("temperature")
      elsif @user_input == "!w"
        graph_maker("wind_speed")
      elsif @user_input == "!s"
        graph_maker("summary")
      else
        puts "please enter a valid command"
        comparison_presenter
      end

  end

  def graph_maker(variable)

      if variable == "temperature"
        unit = "F"
      elsif variable == "wind_speed"
        unit = "MPH"
      end

      delay_print
      clear_screen
      presenter_array = @user_array.sort {|a,b| a.send(variable) <=> b.send(variable)}
      lines
      puts "RANKED LIST by " + variable.to_s
      lines
      presenter_array.each_with_index do |item, index|
        puts "#{index + 1}. #{item.formatted_address} : #{item.send(variable)} #{unit}"
      end

      if variable == "temperature" || variable == "wind_speed"
        graph(presenter_array, variable)
      else

      end

      comparison_presenter

  end

  def graph(city_arr, sorter)

      lower_bound_data = city_arr[0].send(sorter)
      upper_bound_data = city_arr[-1].send(sorter)
      lower_bound_graph = lower_bound_data.round(-1) - 10
      upper_bound_graph = upper_bound_data.round(-1) + 10
      graph_width = upper_bound_graph - lower_bound_graph
      string_start = lower_bound_data - lower_bound_graph
      range = upper_bound_graph - lower_bound_graph
      digits = range / 10

      simple
      lines
      puts sorter + "  graph :::::::"
      lines
      i = 0
      simple

      while (i < digits)
        print (lower_bound_graph + i*10).to_s + "--------"
        i += 1
      end
      puts ""

      city_arr.each do |city|
        puts (" " * (city.send(sorter) - lower_bound_graph)) + city.send(sorter).to_s + " :: " + city.formatted_address
      end
        simple
      comparison_presenter

  end

  def fetch_data(city)
    new_api = API.new(city)
    new_api.googe_api_fetch
    user_city = new_api.format_city
  end

  def help
    lines
    puts "!L = Listing mode => list weather details for a location"
    puts "!C = Comparison mode => compare weather from different locations"
    puts "help = help file"
    puts "exit = exit"
    puts "Input locations as a normal street address or a city state or city country"
    lines
    get_user_input
  end

  def exit_s
    medium_print
    puts "Goodbye!"
    exit
  end

end
