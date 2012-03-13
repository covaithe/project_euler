#!/usr/bin/env ruby

class Integer
  def is_lychrel?
    iteration = 1
    r = self
    while iteration <= 50 do
      reversed = r.reverse
      sum = r + reversed
      if sum.is_palindrome?
        return false 
      end

      iteration += 1
      r = sum
    end
    true
  end

  def reverse
    to_s.reverse.to_i
  end

  def is_palindrome?
    s = to_s
    s == s.reverse
  end

end

puts 1.upto(9999).select(&:is_lychrel?).length
