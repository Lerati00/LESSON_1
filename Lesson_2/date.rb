reg = /^(\d{2}).\d{2}.(\d{4})$/
sequence_number = 0;
months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "Ввести число, месяц и год в формате 'dd.mm.yyyy'"
string_date = gets.chomp
if string_date.scan(reg).empty?
  puts "Формат вводу не коректный"
else
  day, month, year = string_date.split('.').map(&:to_i)
  leap_year = year % 4 == 0 && year % 100 != 0 || year % 400 == 0
  months[1] += 1 if leap_year

  if month <= 12 && month > 0   
    if day > 0 && day <= months[month - 1]
      sequence_number = months.take(month - 1).reduce(:+) + day
    else
      puts "Неправильно указано число"
    end
  else
    puts "Неправильно указаный месяц"
  end
end
sequence_number = "Error" if sequence_number <= 0
puts "Порядковий номер: #{sequence_number}"
