#!/usr/bin/env ruby

def digits_of(n, base=10)
  digits = []
  while n > 0
    digits.push(n%base)
    n /= base
  end
  return digits.reverse
end

def assemble(digits)
  digits.inject(0) {|answer,i| answer = answer*10 + i}
end

def is_palindrome?(n, base=10)
  digits = digits_of(n, base)
  backwards = digits.reverse
  until digits.length == 0
    a = digits.pop()
    b = backwards.pop()
    return false if a != b
  end
  return true
end

class Integer
  def is_lychrel?
    iteration = 1
    r = self
    while iteration <= 50 do
      reversed = r.reverse
      sum = r + reversed
      if is_palindrome? sum
        return false 
      end

      iteration += 1
      r = sum
    end
    true
  end

  def reverse
    assemble(digits_of(self).reverse)
  end

end

puts 1.upto(9999).select(&:is_lychrel?).length
