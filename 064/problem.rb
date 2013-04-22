# Exactly four continued fractions of sqrt(N), for N <= 13, have an odd period.
#
# How many continued fractions of sqrt(N) for N <= 10000 have an odd period?

require_relative 'lib/cf'

class Integer
  def is_odd?
    self % 2 == 1
  end

  def is_square?
    Math.sqrt(self).floor**2 == self
  end

  def sqrt_continued_fraction
    ContinuedFraction.from_sqrt(self)
  end
end

class Problem
  def solve
    count = 0
    1.upto(10000).each do |n|
      next if n.is_square?
      count += 1 if n.sqrt_continued_fraction.period.is_odd?
    end
    puts count
  end
end

Problem.new.solve
