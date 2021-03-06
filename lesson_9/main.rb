require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'menu_constants.rb'

class Main
  attr_accessor :stations, :trains, :routes, :carriages

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @carriages = []
    @message = ''
  end

  def default_data
    @trains = [
      PassengerTrain.new('P2000'),
      PassengerTrain.new('P2010'),
      PassengerTrain.new('P2002'),
      PassengerTrain.new('P20-30'),
      PassengerTrain.new('P2004'),
      CargoTrain.new('C1010'),
      CargoTrain.new('C10-20'),
      CargoTrain.new('C1003'),
      CargoTrain.new('C1004'),
      CargoTrain.new('C1005')
    ]
    @stations = [
      Station.new('Львов'),
      Station.new('Киев'),
      Station.new('Тернопиль'),
      Station.new('Краков'),
      Station.new('Чоп'),
      Station.new('Хмельницк')
    ]

    @carriages = [
      PassengerCarriage.new(100),
      CargoCarriage.new(100),
      CargoCarriage.new(100),
      CargoCarriage.new(100),
      CargoCarriage.new(100),
      CargoCarriage.new(100)
    ]

    5.times.each { |index| @routes << Route.new(@stations[0], @stations[index]) unless index == 0 }
  end

  def main_menu
    loop do
      print MAIN_MENU
      case gets.to_i
      when 1 then trains_menu
      when 2 then stations_menu
      when 3 then routes_menu
      when 4 then carriages_menu
      when 5 then press_enter unless print(HELP)
      when 0 then break
      else next
      end
    end
  end

  private

  include MenuConstants

  attr_accessor :message

  def trains_menu
    loop do
      print TRAINS_MENU
      case gets.to_i
      when 1 then create_train
      when 2 then display_trains
      when 3 then set_route_by_train
      when 4 then display_route_by_train
      when 5 then redact_carriage
      when 6 then move_train
      when 7 then display_carriages_by_train
      when 0 then break
      else next
      end
      press_enter
    end
  end

  def stations_menu
    loop do
      print STATIONS_MENU
      case gets.to_i
      when 1 then create_station
      when 2 then display_stations
      when 3 then display_trains_by_stadion
      when 0 then break
      else next
      end
      press_enter
    end
  end

  def routes_menu
    loop do
      print ROUTES_MENU
      case gets.to_i
      when 1 then create_route
      when 2 then display_routes
      when 3 then redact_route
      when 0 then break
      else next
      end
      press_enter
    end
  end

  def create_station
    puts SET_NAME_STATION
    station = Station.new(gets.chomp)
    @stations << station
    puts CREATED_STATION + station.name
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def display_stations(stations = self.stations)
    puts "Индекс\t\t\tНазвание станции"
    stations.each_with_index { |station, index| puts "#{index}: \t\t\t#{station.name}" }
  end

  def create_train
    puts SELECT_TYPE_TRAIN
    type_train = get_by_index([PassengerTrain, CargoTrain], gets.to_i - 1) while type_train.nil?
    begin
      puts SET_NUMBER_TRAIN
      number = gets.chomp
      train = type_train.new(number)
      @trains << train
      puts CREATED_TRAIN + "#{train.type} #{train.number}"
    rescue RuntimeError => e
      puts e.message
      retry
    end
  end

  def set_route_by_train
    puts 'Список всех поездов'
    display_trains
    puts 'Введите индекс поезда которому хотите задать маршрут'
    train = get_by_index(trains, gets)
    return error_message(INVALID_INDEX) if train.nil?

    display_routes
    puts 'Введите индекс маршрута который вы хотите задать'
    route = get_by_index(routes, gets)
    return error_message(INVALID_INDEX) if route.nil?

    train.route = route
    @message = 'Маршрут успешно создан'
    puts message
  end

  def display_trains_by_stadion
    display_stations
    puts 'Введите индекс станции'
    station = get_by_index(stations, gets)
    return error_message(INVALID_INDEX) if station.nil?

    puts "Бортовой номер\tТип\t\tКоличество вагонов"
    station.each_train do |train|
      puts "#{train.number}\t\t#{train.type}\t\t#{train.carriages_count}"
    end
  end

  def display_route_by_train
    display_trains
    puts 'Введите индекс поезда маршрут которого хотите вивести'
    train = get_by_index(trains, gets)
    return error_message(INVALID_INDEX) if train.nil?
    return error_message('В поезде отсутствует маршрут') if train.route.nil?

    puts train.route.name.to_s
    train.route.stations.each { |station| puts station.name }
  end

  def redact_carriage
    display_trains
    puts 'Введите индекс поезда в котором хотите изменить количество вагонов'
    train = get_by_index(trains, gets)
    return error_message(INVALID_INDEX) if train.nil?

    puts "Количество вагонов #{train.carriages_count}"
    puts 'Чтоби добавить введите [1]'
    puts 'Чтоби удалить введите [2]'
    carriages_ = carriages.select do |carriage_|
      carriage_.type == train.type && carriage_.train != train
    end
    carriage = carriages_.first
    return puts CAR_SHORTAGE_ERROR if carriage.nil?

    carriage.train = train
    case gets.to_i
    when 1 then @message = 'Вагон добавлен' if train.add_carriage(carriage)
    when 2 then @message = 'Вагон отцеплен' if train.delete_carriage
    else @message = 'Вы ввели недопустимое значенние'
    end
    puts message
  end

  def move_train
    display_trains
    puts 'Введите индекс поезда который хотите переместить'
    train = get_by_index(trains, gets)
    return error_message(INVALID_INDEX) if train.nil?
    return error_message('В поезде отсутствует маршрут') if train.route.nil?

    puts 'Чтоби переместить на одну станцию вперед введите [1]'
    puts 'Чтоби переместить на одну станцию назад введите [2]'
    @message =
      case gets.to_i
      when 1
        if train.move_forward
          'Поезд переместился на станцию вперед'
        else
          'Поезд уже на конечной станции'
        end
      when 2
        if train.move_back
          'Поезд переместился на станцию назад'
        else
          'Поезд уже на начальной станции'
        end
      else 'Вы ввели недопустимое значенние'
      end
    puts message
  end

  def display_trains(trains = self.trains)
    puts "Индекс\t\tБортовой номер\tТип\t\tКоличество вагонов"
    trains.each_with_index do |train, index|
      puts "#{index} \t\t#{train.number}\t\t#{train.type}\t\t#{train.carriages_count}"
    end
  end

  def create_route
    display_stations
    puts 'Введите индекс начальной станции'
    first_station = get_by_index(stations, gets)
    return error_message(INVALID_INDEX) if first_station.nil?

    puts 'Введите индекс конечной станции'
    last_station = get_by_index(stations, gets)
    return error_message(INVALID_INDEX) if last_station.nil?

    route = Route.new(first_station, last_station)
    @routes << route
    puts CREATED_ROUTE + route.name
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def redact_route
    display_routes
    puts 'Введите индекс маршрута в котором хотите сделать изменения'
    route = get_by_index(routes, gets)
    return error_message(INVALID_INDEX) if route.nil?

    puts "Хотите добавить станцию в маршрута #{route.name} введите [1]"
    puts "Хотите удалить станцию с маршрута #{route.name} введите [2]"
    case gets.to_i
    when 1 then add_station_by_route(route)
    when 2 then delete_station_by_route(route)
    else @message = 'Вы ввели недопустимое значенние'
    end
    puts message
  end

  def add_station_by_route(route)
    loop do
      puts 'Список всех станций'
      display_stations
      puts 'Список всех станций в маршруте'
      display_stations(route.stations)
      puts 'Введите индекс cтанции из "Список всех станций",' \
           " которую хотите добавить в маршрут \"#{route.name}\""
      puts 'Чтоби прекратить введите [stop] '
      choice = gets.chomp
      break if stop?(choice)

      station = get_by_index(stations, choice)
      return error_message(INVALID_INDEX) if station.nil?

      route.add_station(station)
    end
  end

  def delete_station_by_route(route)
    puts 'Список всех станций в маршруте'
    display_stations(route.stations)
    puts 'Введите индекс cтанции из "Список всех станций в маршруте",' \
         " которую хотите удалить из маршрута \"#{route.name}\""
    puts 'Вы не можете удалить начальую и конечную станции'
    puts 'Чтоби прекратить введите [stop] '
    choice = gets.chomp
    return if stop?(choice)

    station = get_by_index(route.stations, choice)
    raise INVALID_INDEX if station.nil?

    route.delete_station(station)
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def display_routes
    puts "Индекс\t\t\tНазвание маршрута"
    routes.each_with_index { |route, index| puts "#{index}: \t\t\t#{route.name}" }
  end

  def number?(number)
    number = number.to_s
    number[/^\d+$/] ? number.to_i : nil
  end

  def error_message(message)
    puts message
  end

  def press_enter
    puts 'Нaжмите [ENTER]'
    gets
  end

  def get_by_index(array, index)
    element = number?(index) ? array[index.to_i] : nil
    element.nil? ? nil : element
  end

  def stop?(stop)
    stop.chomp.casecmp('stop').zero?
  end

  def carriages_menu
    loop do
      print CARRIAGES_MENU
      case gets.to_i
      when 1 then create_carriage
      when 2 then reserve_in_carriage
      when 3 then display_carriages
      when 0 then break
      else next
      end
      press_enter
    end
  end

  def create_carriage
    puts SELECT_TYPE_CARRIAGE
    carriage_types = [PassengerCarriage, CargoCarriage]
    carriage_type = get_by_index(carriage_types, gets.to_i - 1) while carriage_type.nil?
    message = if carriage_type == PassengerCarriage
                'Введите количество мест'
              else
                'Введите обьем вагона'
              end
    puts message
    carriage = if carriage_type == PassengerCarriage
                 carriage_type.new(gets.to_i)
               else
                 carriage_type.new(gets.to_f)
               end
    carriages << carriage
    puts CREATED_CARRIAGE + carriage.type.to_s
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def display_carriages_by_train
    display_trains
    puts 'Введите индекс поезда, вагоны которого хотите вывести'
    train = get_by_index(trains, gets)
    return error_message(INVALID_INDEX) if train.nil?

    if train.is_a?(PassengerTrain)
      puts "Номер\t\tТип\t\tКол-во мест\t\tКол-во занятих мест"
      train.each_carriage do |carriage, index|
        puts "#{index + 1}\t\t#{carriage.type}\t\t" \
             "#{carriage.number_places}\t\t#{carriage.taking_places}"
      end
    elsif train.is_a?(CargoTrain)
      puts "Номер\t\tТип\t\tОбъем\t\tЗанятый объем"
      train.each_carriage do |carriage, index|
        puts "#{index + 1}\t\t#{carriage.type}\t\t#{carriage.volume}\t\t#{carriage.taking_volume}"
      end
    end
  end

  def display_carriages
    puts "Индекс\t\tТип\t\tМесто/Обьем\tЗанято"
    carriages.each_with_index do |carriage, index|
      puts "#{index}\t\t#{carriage.type}\t\t#{carriage.total}\t\t#{carriage.busy}"
    end
  end

  def reserve_in_carriage
    display_carriages
    puts 'Введите индекс вагона, в котором хотите занять место'
    carriage = get_by_index(carriages, gets)
    return error_message(INVALID_INDEX) if carriage.nil?

    carriage.take_place if carriage.is_a?(PassengerCarriage)
    if carriage.is_a?(CargoCarriage)
      print 'Введите обьем которий хотите занять: '
      carriage.take_volume(gets.to_f)
    end
    puts 'Выполнено'
  rescue RuntimeError => e
    puts e.message
  end
end

main = Main.new
main.default_data
main.main_menu
