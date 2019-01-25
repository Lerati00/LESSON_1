vowels = ['a', 'e', 'i', 'o', 'u']
hash_vovels = Hash.new
num = 0
("a".."z").each do |s|
  if vowels.include?(s)
    hash_vovels[s] = num
    puts "#{s}: #{num}"
  end
  num += 1
end