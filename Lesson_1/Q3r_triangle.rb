sides = []
triangle_types = []
puts "Введите сторону_1 триугольника?"
sides.push(gets.to_i)
puts "Введите сторону_2 триугольника?"
sides.push(gets.to_i)
puts "Введите сторону_3 триугольника?"
sides.push(gets.to_i)
sides.sort!

if (sides[2]**2).round(3) == (sides[1]**2 + sides[0]**2).round(3)
  triangle_types.push("Прямоугольный треугольник")
end

if sides[0] == sides[1] || sides[2] == sides[1] 
  triangle_types.push("Равнобедренный треугольник")
end

if sides[0] == sides[2]
  triangle_types.push("Равносторонний треугольник")
end

if triangle_types.empty?
  triangle_types.push("Просто триугольник")
end

triangle_types.each do |type| 
  print "[#{type}]"
end
