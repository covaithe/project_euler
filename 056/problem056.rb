

class Integer
  def digit_sum
    to_s.chars.map(&:to_i).inject(0,&:+)
  end
end

puts "digit sum of 1 is #{1.digit_sum}"
puts "digit sum of 12 is #{12.digit_sum}"
puts "digit sum of 1000000000 is #{1000000000.digit_sum}"

max = 0
1.upto(99).each do |a|
  1.upto(99).each do |b|
    sum = (a ** b).digit_sum
    max = sum if sum > max
  end
end
puts max
