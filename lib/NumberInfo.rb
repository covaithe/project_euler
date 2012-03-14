
require_relative "./Primes"

module NumberInfo
  @is_prime

  def is_prime?
    @is_prime ||= Primes.is_prime? self
  end

  def digits_of(base=10)
    digits = []
    n = self
    while n > 0
      digits.push(n%base)
      n /= base
    end
    return digits.reverse
  end

  def is_permutation_of?(q)
    p = self
    pdigits = p.digits_of.sort
    qdigits = q.digits_of.sort
    return false unless pdigits.length == qdigits.length
    (0..pdigits.length).each do |i|
      return false unless pdigits[i] == qdigits[i]
    end
    return true
  end

  def is_pandigital?(n = 9)
    return false if self > 987654321
    digits = digits_of(self)
    1.upto(n) {|i| return false unless digits.include?(i) }
    true
  end

end

class Integer
  include NumberInfo
end
