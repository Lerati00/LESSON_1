puts "Введите ваше имя?"
name = gets.chomp.capitalize
puts "Какой увас рост?"
height = gets.to_i
ideal_weigth = height - 110
if ideal_weigth > 0
  puts "#{name},ваш идеальный вес #{ideal_weigth}" 
else
  puts "Ваш вес уже оптимальный" 
end


