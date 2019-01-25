product = Hash.new({ })
all_sum = 0.0
loop do
  puts "Для выхода введите [stop]"
  puts "Введите название товара"
  product_name = gets.chomp
  break if (product_name == "stop")

  puts "Для выхода введите [stop]"
  puts "Введите цену товара"
  product_price = gets.chomp
  break if (product_price == "stop")
  product_price = product_price.to_f.round(2)

  puts "Для выхода введите [stop]"
  puts "Введите количество товара"
  product_number = gets.chomp
  break if (product_number == "stop")
  product_number = product_number.to_i

  product[product_name] = { product_price => product_number }
end
puts "Название\tЦена\tКоличество\t\tИтоговая сума"
product.each do |name, kesh|
  kesh.each do |price, num|
    sum = price * num
    all_sum += sum
    puts "#{name}\t\t#{price}\t\t#{num}\t\t#{sum}"
  end
end
puts "Итоговую сумму всех покупок в корзине\t#{all_sum.round(2)}"