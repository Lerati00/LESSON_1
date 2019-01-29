cart = {}
total = 0.0

loop do
  puts "Для выхода введите [stop]"
  puts "Введите название товара"
  item_name = gets.chomp
  break if item_name.downcase == "stop"

  puts "Введите цену товара"
  choice = gets.chomp
  break if (choice == "stop")
  item_price = choice.to_f.round(2)

  puts "Введите количество товара"
  choice = gets.chomp
  break if (choice == "stop")
  item_quantity = choice.to_i

  cart[item_name] = { price: item_price, quantity: item_quantity }
end

puts "Название\tЦена\tКоличество\t\tИтоговая сума"
cart.each do |name, hash|
  sum = hash[:price] * hash[:quantity]
  total += sum
  puts "#{name}\t\t#{hash[:price]}\t\t#{hash[:quantity]}\t\t#{sum}"
end
puts "Итоговую сумму всех покупок в корзине\t#{total.round(2)}"
