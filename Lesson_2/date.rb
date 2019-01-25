reg = /^(\d{2}).\d{2}.(\d{4})$/
sequence_number = 0;
months = { 1 => { january: 31 },
           2 => { february: 28 },
           3 => { march: 31 },
           4 => { april: 30 },
           5 => { may: 31 },
           6 => { june: 30 },
           7 => { july: 31 },
           8 => { august: 31 },
           9 => { september: 30 },
           10 => { october: 31 },
           11 => { november: 30 },
           12 => { december: 31 }
        }

puts "Ввести число, месяц и год в формате 'dd.mm.yyyy'"
string_date = gets.chomp
if string_date.scan(reg).empty?
  puts "Формат вводу не коректный"
else
  array_date = string_date.split(".").collect { |a| a.to_i }

  leap_year = false
  if (array_date[2] % 4) ==0
    leap_year = true
    if (array_date[2] % 100) ==0
      leap_year = false
      if (array_date[2] % 400) ==0
        leap_year = true
      end
    end
  end

  if leap_year
    months[2][:february] += 1
  end

  if months.include?(array_date[1])   
    months[array_date[1]].each do |k, days_in_month|
      if array_date[0].to_i > 0 && array_date[0].to_i <= days_in_month
        sequence_number += array_date[0]
        for num in (1..array_date[1]-1)
          months[num].each do |k, days_in_month|
            sequence_number += days_in_month
          end
        end
      else
        puts "Неправильно указано число"
      end
    end
  else
    puts "Неправильно указаный месяц"
  end
end

puts "Порядковий номер: #{sequence_number}"
