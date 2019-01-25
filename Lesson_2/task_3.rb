fibonacci = [0, 1]
loop do
  size = fibonacci.size
  fibonacci[size] = fibonacci[size - 1] + fibonacci[size - 2]
  if fibonacci.size >= 100
    break
  end
end

fibonacci.each { |f| puts f }