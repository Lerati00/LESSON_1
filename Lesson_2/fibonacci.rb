fibonacci = [0, 1]
loop do
  next_number = fibonacci[-1] + fibonacci[-2]
  break if next_number > 100
  fibonacci << next_number
end

fibonacci.each { |f| puts f }
