puts "Введите ваше имя?"
name=gets.chomp
name.capitalize!
puts "Какой увас рост?"
height=gets.chomp
ideal_weigth = height.to_i - 110
if ideal_weigth > 0
    puts "#{name},ваш идеальный вес #{ideal_weigth.to_s}" 
else
    puts "Ваш вес уже оптимальный" 
end

