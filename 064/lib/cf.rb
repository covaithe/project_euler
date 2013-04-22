
class ContinuedFraction

  def self.from_sqrt(n)
    cf = ContinuedFraction.new
    cf.squared = n
    cf
  end

  def m(i)
    fetch_or_create_mda(i).m
  end

  def d(i)
    fetch_or_create_mda(i).d
  end

  def a(i)
    fetch_or_create_mda(i).a
  end

  def period
    i = 2
    loop do
      1.upto(i-1).each do |j|
        a = fetch_or_create_mda(i)
        b = fetch_or_create_mda(j)
        return i - j if a == b
      end
      i += 1
    end
  end

  attr_accessor :squared

  private 

  attr_accessor :stored_mda

  def initialize
    self.stored_mda = []
  end

  class Mda < Struct.new(:m, :d, :a)
  end

  def fetch_or_create_mda(i)
    if stored_mda.size < i+1
      calc_mda(i)
    end
    stored_mda[i]
  end

  def calc_mda(i)
    m = if i == 0
          0
        else
          a(i-1)*d(i-1) - m(i-1)
        end

    d = if i == 0
          1
        else
          (squared - m*m) / d(i-1)
        end

    a = if i == 0
          Math.sqrt(squared).floor
        else
          (a(0) + m) / d
        end
    mda = Mda.new(m, d, a)
    stored_mda << mda
    mda
  end
end
