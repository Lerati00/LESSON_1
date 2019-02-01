require_relative "passenger_train.rb"
require_relative "cargo_train.rb"
require_relative "route.rb"
require_relative "station.rb"
require_relative "menu_constants.rb"

class Main
  include MenuConstants
  attr_accessor :stations, :trains, :routes
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def default_data  
    @trains = [
      PassengerTrain.new("P200"), 
      PassengerTrain.new("P201"), 
      PassengerTrain.new("P202"), 
      PassengerTrain.new("P203"), 
      PassengerTrain.new("P204"),
      CargoTrain.new("C101"),
      CargoTrain.new("C102"),
      CargoTrain.new("C103"),
      CargoTrain.new("C104"),
      CargoTrain.new("C105")
    ]
    @stations = [
      Station.new("Львов"),
      Station.new("Киев"),
      Station.new("Тернопиль"),
      Station.new("Краков"),
      Station.new("Чоп"),
      Station.new("Хмельницк"),
    ]
     
    5.times.each { |index| @routes << Route.new(@stations[0], @stations[index]) unless index == 0 }
  end

  def main_menu
    loop do
      print TEXT_MAIN_MENU
      choice = gets.chomp
      case choice.downcase
      when "1"
        trains_menu
      when "2"
        stations_menu
      when "3"
        routes_menu
      when "4" || "help"
        print TEXT_HELP
        gets
      when "0" || "exit"
        break
      else
        next
      end
    end
  end

  private
  
  def trains_menu
    loop do
      print TEXT_TRAINS_MENU
      choice = gets.chomp
      case choice.downcase
      when "1"
        create_train
      when "2"
        display_trains
      when "3"
        set_route_by_train
      when "4"
        display_route_by_train
      when "5"
        redact_carriage
      when "6"
        move_train
      when "0" || "menu"
        break
      else
        next
      end
      puts "Нaжмите [ENTER]"
      gets
    end
  end

  def stations_menu
    loop do
      print TEXT_STATIONS_MENU
      choice = gets.chomp
      case choice.downcase
      when "1"
        create_station
      when "2"
        display_stations
      when "3"
        display_stations
        puts "Введите индекс станции"
        index_station = gets.to_i
        display_trains(stations[index_station].trains)
      when "0" || "menu"
        break
      else
        next
      end
      puts "Нaжмите [ENTER]"
      gets
    end
  end

  def routes_menu
    loop do
      print TEXT_ROUTES_MENU
      choice = gets.chomp
      case choice.downcase
      when "1"
        create_route
      when "2"
        display_routes
      when "3"
        redact_route
      when "0" || "menu"
        break
      else
        next
      end
      puts "Нaжмите [ENTER]"
      gets
    end
  end

  def create_station
    puts "Введите название станции"
    name = gets.chomp
    @stations << Station.new(name)
    puts "Станция успешно созданa"
  end

  def display_stations(stations = self.stations)
    puts "Индекс\t\t\tНазвание станции"
    stations.each_with_index { |station, index| puts "#{index}: \t\t\t#{station.name}"}
  end

  def create_train
    message = "Поезд успешно создан"
    puts "Введите бортовой номер поезда"
    number = gets.chomp
    puts "Введите тип поезда "
    puts "Если пассажирский введите [P](Passenger)"
    puts "Если грузовой введите [C](Cargo)"
    choice = gets.chomp
    case choice.downcase
    when "p" || "passenger"
      @trains << PassengerTrain.new(number)
    when "c" || "cargo"
      @trains << CargoTrain.new(number)
    else
      message = "Неправильно введен тип поезда"
    end
    puts "#{message}"
  end

  def set_route_by_train
    puts "Список всех поездов"
    display_trains
    puts "Введите индекс поезда которому хотите задать маршрут"
    train = trains[gets.to_i]
    return puts INVALID_INDEX if train.nil?
    display_routes 
    puts "Введите индекс маршрута который вы хотите задать"
    route = routes[gets.to_i]
    return puts INVALID_INDEX if route.nil? 
    train.set_route(route)
  end

  def display_route_by_train
    display_trains
    puts "Введите индекс поезда маршрут которого хотите вивести"
    train = trains[gets.to_i]
    return puts(INVALID_INDEX) if train.nil?
    puts "#{train.route.name}"
    train.route.display_stations
  end

  def redact_carriage
    display_trains
    puts "Введите индекс поезда в котором хотите изменить количество вагонов"
    train = trains[gets.to_i]
    return puts(INVALID_INDEX) if train.nil?
    puts "Количество вагонов #{train.carriages_count}"
    puts "Чтоби добавить введите [1]"
    puts "Чтоби удалить введите [2]"
    choice = gets.chomp
    case choice.downcase
    when "1"
      train.add_carriage
    when "2"
      train.delete_carriage
    end
  end

  def move_train
    display_trains
    puts "Введите индекс поезда который хотите переместить"
    train = trains[gets.to_i]
    return puts(INVALID_INDEX) if train.nil?
    puts "Чтоби переместить на одну станцию вперед введите [1]"
    puts "Чтоби переместить на одну станцию назад введите [2]"
    choice = gets.chomp
    case choice.downcase
    when "1"
      train.move_forward
    when "2"
      train.move_back
    else
    end
  end

  def display_trains(trains = self.trains)
    puts "Индекс\t\tБортовой номер\tТип\t\tКоличество вагонов"
    trains.each_with_index { |train, index| puts "#{index} \t\t#{train.number}\t\t#{train.type}\t\t#{train.carriages_count}"}
  end

  def create_route
    display_stations
    puts "Введите индекс начальной станции"
    first_station = stations[gets.to_i]
    return puts INVALID_INDEX if first_station.nil? 
    puts "Введите индекс конечной станции"
    last_station = stations[gets.to_i]
    return puts INVALID_INDEX if last_station.nil? 
    @routes << Route.new(first_station, last_station)
    puts "Маршрут создан"
  end

  def redact_route
    display_routes
    puts "Введите индекс маршрута в котором хотите сделать изменения"
    puts "Чтоби прекратить введите [stop] "
    choice = gets.chomp
    return if choice.downcase == "stop"
    route = routes[choice.to_i]
    return puts(INVALID_INDEX) if route.nil? 
    puts "Хотите добавить станцию в маршрута #{route.name} введите [1]"
    puts "Хотите удалить станцию с маршрута #{route.name} введите [2]"

    choice = gets.chomp
    case choice.downcase
    when "1"    
      add_station_by_route(route) 
    when "2"
      delete_station_by_route(route)
    when "stop"
    end
  end

  def add_station_by_route(route)
    loop do
      puts "Список всех станций"
      display_stations
      puts "Список всех станций в маршруте"
      display_stations(route.stations)
      puts "Введите индекс cтанции из \"Список всех станций\", которую хотите добавить в маршрут \"#{route.name}\""
      puts "Чтоби прекратить введите [stop] "
      choice = gets.chomp
      break if choice.downcase == "stop"
      station = stations[choice.to_i]
      return puts INVALID_INDEX if station.nil? 
      route.add_station(station)
    end
  end

  def delete_station_by_route(route)
    loop do
      puts "Список всех станций в маршруте"
      display_stations(route.stations)
      puts "Введите индекс cтанции из \"Список всех станций в маршруте\", которую хотите удалить из маршрута \"#{route.name}\""
      puts "Вы не можете удалить начальую и конечную станции"
      puts "Чтоби прекратить введите [stop]  "
      choice = gets.chomp
      break if choice.downcase == "stop"
      station = route.stations[choice.to_i]
      return puts INVALID_INDEX if station.nil?
      route.delete_station(station)
    end
  end

  def display_routes
    puts "Индекс\t\t\tНазвание маршрута"
    routes.each_with_index { |route, index| puts "#{index}: \t\t\t#{route.name}"}
  end
  
end


main = Main.new
main.default_data
main.main_menu


