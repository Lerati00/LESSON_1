puts "Введите онование триугольника?"
line=gets.chomp
line = line.to_i
puts "Введите высоту триугольника?"
height=gets.chomp
height = height.to_i

area_triangle = 0.5 * line * height

puts "Площадь триугольника #{area_triangle.to_s}"