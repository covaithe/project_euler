
cipher = File.read("cipher1.txt")
cipher_chars = cipher.split(",")

possible_keys = Enumerator.new do |yielder| 
  'a'.upto('z').each do |a|
    'a'.upto('z').each do |b|
      'a'.upto('z').each do |c|
        yielder << a+b+c
      end
    end
  end
end

potentials = {}

possible_keys.each do |key|
  # puts "testing key #{key}"

  bad_key = false
  keybytes = key.codepoints.to_a

  plain_chars = []
  i = -1
  cipher_chars.each do |cc|
    i += 1
    pc = cc.to_i ^ keybytes[i % key.length]

    if pc > 127 ||
       i > 12 && !plain_chars.include?(" ".bytes.to_a[0])

      bad_key = true
      break
    end

    plain_chars << pc
  end

  next if bad_key

  plaintext = ""
  plain_chars.each {|c| plaintext << c}
  sum = plain_chars.inject(0,&:+)
  potentials[key] = sum.to_s + " " +  plaintext
  # puts "plaintext:  #{plaintext}"
end

# potentials.each do |key,plaintext|
  # puts "#{key}: #{plaintext[0..50]}"
# end

puts "god: #{potentials["god"][0..50]}"
