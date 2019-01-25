puts "Введите a,b,c в уравнение [a*x**2 + b*x + c]"
puts "Програма выведет значение дискриминанта и корней на экран"
puts "Введите a"
a = gets.to_f
puts "Введите b"
b = gets.to_f
puts "Введите c"
c = gets.to_f
dis = b**2 - 4 * a * c
puts "Дискриминант #{dis.to_s}"
if dis > 0
  sqrt = Math.sqrt(dis)
  x1 = (-b + sqrt) / (2.0 * a)
  x2 = (-b - sqrt) / (2.0 * a)
  puts "Корни [#{x1.round(4)}] [#{x2.round(4)}]"
elsif dis == 0
  x = -b / (2.0 * a)
  puts "Корень [#{x}]"
else
  puts "Корней нет"
end
