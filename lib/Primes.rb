
class Primes
  @@known_primes = [ 2, 3, 5, 7, 11, 13, 17, 19, 23 ]
  def initialize()
  end

  def Primes.known_primes
    @@known_primes
  end

  def Primes.exponent_vector(n)
    return [] if n == 1
    factors = factorize(n)
    # puts "foo: " + factors.join(", ")
    maxindex = @@known_primes.index(factors[-1])
    vec = []
    for i in (0..maxindex)
      t = factors.find_all { |o| o == @@known_primes[i] }
      vec[i] = t.length
    end
    return vec
  end

  def Primes.factorize(n)
    calculate_primes_to(n)
    factors = []
    i = 0
    d = @@known_primes[i]
    while n > 1
      while n%d == 0
        factors << d
        n /= d
      end
      i += 1
      d = @@known_primes[i] || d+1
      d = n if d > Math.sqrt(n)
    end
    factors
  end

  def Primes.remove_multiples(last, n, array)
      # puts "marking multiples of #{n}"
      return if array == nil
      return if array.length == 0
      return if n == nil
      i = 3*n
      while i <= last
          if array[i] == 1
            # puts "marking #{i} as not prime"
            array[i] = -1
          end
          i += 2*n
      end
  end

  def Primes.calculate_primes_to(n)
    return if @@known_primes[-1] >= n

    remaining = {} 
    offset = @@known_primes[-1] + 2
    offset.step(n,2) { |i| remaining[i] = 1 }

    # don't consider multiples of known primes
    @@known_primes.each { |p| 
        next if p == 2
        remove_multiples(n, p, remaining) 
    }

    # puts "finished considering known primes, now consider new primes."
    offset.step(n,2) do |p|
        next if remaining[p] == -1
        next if remaining[p] == nil
        # puts "found new prime #{p}"
        @@known_primes.push(p)
        remove_multiples(n, p, remaining)
    end
  end

  def Primes.is_prime?(n)
    calculate_primes_to(n)

    low = 0
    high = @@known_primes.length-1

    while low <= high
      mid = (low + high)/2
      p = @@known_primes[mid]

      if p < n
        low = mid + 1
      elsif p > n
        high = mid-1
      else
        return true
      end
    end
    
    return false
  end

end

