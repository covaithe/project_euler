require "./continued_fraction.rb"

# two problems:  
#  1.  create the nth iteration of the continued fraction
#  2.  expand the numerator and denominator.
# n.b:  might not be fruitful to separate them.

count = 0

1.upto(1000).each do |n|
  f = ContinuedFraction.new(n)
  count += 1 if(f.numerator.to_s.length > f.denominator.to_s.length)
end

puts count

