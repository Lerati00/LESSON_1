puts "Введите a,b,c в уравнение [a*x**2 + b*x + c]"
puts "Програма выведет значение дискриминанта и корней на экран"
puts "Введите a"
a = Integer(gets.chomp)
puts "Введите b"
b = Integer(gets.chomp)
puts "Введите c"
c = Integer(gets.chomp)
dis = b**2 - 4 * a * c
x =[]
puts "Дискриминант #{dis.to_s}"
if dis>0
    x.push((-b+Math.sqrt(dis))/(2* a))
    x.push((-b-Math.sqrt(dis))/(2* a))
    puts "Корни [#{x[0].round(4)}] [#{x[1].round(4)}]"
elsif dis==0
    x.push(-b/(2* a))
    puts "Корень [#{x[0]}]"
else
    puts "Корней нет"
end
