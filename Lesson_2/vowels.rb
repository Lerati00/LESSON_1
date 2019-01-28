hash_vowels = {}
("a".."z").each_with_index { |letter, index| hash_vowels[letter] = index if !letter.scan(/^(a|e|i|o|u){1}/).empty? }
