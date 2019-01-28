reg = /^(\d{2}).\d{2}.(\d{4})$/
sequence_number = 0;
months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "Ввести число, месяц и год в формате 'dd.mm.yyyy'"
string_date = gets.chomp
abort("Формат вводу не коректный") if string_date.scan(reg).empty?
  day, month, year = string_date.split('.').map(&:to_i)
  leap_year = year % 4 == 0 && year % 100 != 0 || year % 400 == 0
  months[1] += 1 if leap_year
  abort("Неправильно указаный месяц") unless month.between?(1, 12)   
    abort("Неправильно указано число")  unless day.between?(1, months[month - 1])
      sequence_number = months.take(month - 1).reduce(0,:+) + day

puts "Порядковий номер: #{sequence_number}"
