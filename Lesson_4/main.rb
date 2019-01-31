require_relative "passenger_train.rb"
require_relative "cargo_train.rb"
require_relative "route.rb"
require_relative "station.rb"
require_relative "menu_constants.rb"

class Main
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
      when "trains"
        trains_menu
      when "stations"
        stations_menu
      when "routes"
        routes_menu
      when "help"
        print TEXT_HELP
        gets
      when "exit"
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
      when "create"
        create_train
      when "display_all"
        display_trains
      when "set_route"
        set_route_by_train
      when "display_route"
        display_route_by_train
      when "carriages"
        redact_carriage
      when "move"
        move_train
      when "menu"
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
      when "create"
        create_station
      when "display_all"
        display_stations
      when "display_trains"
        display_stations
        puts "Введите индекс станции"
        index_station = gets.to_i
        display_trains(stations[index_station].trains)
      when "menu"
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
      when "create"
        create_route
      when "display_all"
        display_routes
      when "redact"
        redact_route
      when "menu"
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
    index_train = gets.to_i
    display_routes 
    puts "Введите индекс маршрута который вы хотите задать"
    index_route = gets.to_i
    trains[index_train].set_route(routes[index_route])
  end

  def display_route_by_train
    display_trains
    puts "Введите индекс поезда маршрут которого хотите вивести"
    index_train = gets.to_i
    puts "#{trains[index_train].route.name}"
    trains[index_train].route.display_stations
  end

  def redact_carriage
    display_trains
    puts "Введите индекс поезда в котором хотите изменить количество вагонов"
    index_train = gets.to_i
    puts "Количество вагонов #{trains[index_train].carriages_count}"
    puts "Чтоби добавить введите [add]"
    puts "Чтоби добавить введите [delete]"
    choice = gets.chomp
    case choice.downcase
    when "add"
      trains[index_train].add_carriage
    when "delete"
      trains[index_train].delete_carriage
    else
    end
  end

  def move_train
    display_trains
    puts "Введите индекс поезда который хотите переместить"
    index_train = gets.to_i
    puts "Чтоби переместить на одну станцию вперед введите [forward]"
    puts "Чтоби переместить на одну станцию назад введите [back]"
    choice = gets.chomp
    case choice.downcase
    when "forward"
      trains[index_train].move_forward
    when "back"
      trains[index_train].move_back
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
    first_stantion = gets.to_i
    puts "Введите индекс конечной станции"
    last_stantion = gets.to_i
    @routes << Route.new(stations[first_stantion], stations[last_stantion])
    puts "Маршрут создан"
  end

  def redact_route
    loop do
      display_routes
      puts "Введите индекс маршрута в котором хотите сделать изменения"
      puts "Чтоби прекратить введите [stop] "
      choice = gets.chomp
      return if choice.downcase == "stop"
      index_route = choice.to_i
      puts "Хотите добавить станцию введите [add]"
      puts "Хотите удалить станцию введите [delete]"
      puts "Чтоби прекратить введите [stop] "

      choice = gets.chomp
      case choice.downcase
      when "add"    
        add_station_by_route(index_route) 
      when "delete"
        delete_station_by_route(index_route)
      when "stop"
        break
      else 
        next
      end
    end
  end

  def add_station_by_route(index_route)
    loop do
      puts "Список всех станций"
      display_stations
      puts "Список всех станций в маршруте"
      display_stations(routes[index_route].stations)
      puts "Введите индекс cтанции из \"Список всех станций\", которую хотите добавить в маршрут \"#{routes[index_route].stations[0].name}-#{routes[index_route].stations[-1].name}\""
      puts "Чтоби прекратить введите [stop] "
      choice = gets.chomp
      break if choice.downcase == "stop"
      index_station = choice.to_i
      routes[index_route].add_station(stations[index_station])
    end
  end

  def delete_station_by_route(index_route)
    loop do
      puts "Список всех станций в маршруте"
      display_stations(routes[index_route].stations)
      puts "Введите индекс cтанции из \"Список всех станций в маршруте\", которую хотите удалить из маршрута \"#{routes[index_route].stations[0].name}-#{routes[index_route].stations[-1].name}\""
      puts "Вы не можете удалить начальую и конечную станции"
      puts "Чтоби прекратить введите [stop] "
      choice = gets.chomp
      break if choice.downcase == "stop"
      index_station = choice.to_i
      routes[index_route].delete_station(routes[index_route].stations[index_station])
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


