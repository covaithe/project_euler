module NumberInfo
  def prime?
    return false if self == 1
    return true if self == 2
    return false if self % 2 == 0
    d = 3
    while d <= Math.sqrt(self) do
      return false if self % d == 0
      d += 2
    end

    true
  end
end

class Integer
  include NumberInfo
end

side = 7  #current side length
diagonals = [1, 3, 5, 7, 9, 13, 17, 21, 25, 31, 37, 43, 49]
n = 49
finished = false

primes = []
nonprimes = []

def classify(x, primes, nonprimes)
  if x.prime?
    primes << x
  else
    nonprimes << x
  end
end

diagonals.each { |x| classify(x, primes, nonprimes) }

def calculate_ratio(primes, nonprimes)
  ratio = primes.length.to_f / (primes.length.to_f + nonprimes.length.to_f)
  # puts "#{primes.length} primes, #{nonprimes.length} nonprimes, ratio #{ratio}"
  ratio
end

calculate_ratio primes, nonprimes
  
while !finished do
  4.times do
    n += side+1
    classify(n, primes, nonprimes)
  end
  side += 2
  # puts "side length is #{side}"
  ratio = calculate_ratio primes, nonprimes
  finished = ratio < 0.1
end

puts side



