
class ContinuedFraction
  def initialize(n)
    @fraction = iterate(n)
  end

  def numerator
    @fraction.numerator
  end

  def denominator
    @fraction.denominator
  end

  def iterate(n)
    return Fraction.new(3,2) if n == 1
    f = Fraction.new(1,2)
    1.upto(n-1).each do |i|
      # puts "#{n}: fraction is #{f}"
      # puts "adding #{2*f.denominator} to numerator and inverting: "
      f.numerator += 2 * f.denominator
      f.invert!
      # puts "result is #{f}"
    end
    f.numerator += f.denominator
    # puts "final result is #{f}"
    # puts
    f
  end

  # 2.  one half, plus two, invert, add one.
  # 3.  one half, plus two, invert, plus two, invert, add one.
  # 4.  one half, plus two, invert, plus two, invert, plus two, invert, add one

  class Fraction
    attr_accessor :numerator, :denominator

    def initialize(num, denom)
      @numerator = num
      @denominator = denom
    end
    
    def invert!
      a = @numerator
      @numerator = @denominator
      @denominator = a
    end

    def to_s
      numerator.to_s + "/" + denominator.to_s
    end
  end

end
