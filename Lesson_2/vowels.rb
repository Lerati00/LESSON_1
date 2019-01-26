vowels = %w(a e i o u)
hash_vovels = {}
("a".."z").each_with_index do |letter, index|
  if vowels.include?(letter)
    hash_vovels[letter] = index
    puts "#{letter}: #{index}"
  end
end
