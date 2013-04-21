# Find the sum of the only ordered set of six cyclic 4-digit numbers for which 
# each polygonal type: triangle, square, pentagonal, hexagonal, heptagonal, 
# and octagonal, is represented by a different number in the set.
#
# Triangle    P3,n=n(n+1)/2   1, 3, 6, 10, 15, ...
# Square      P4,n=n2         1, 4, 9, 16, 25, ...
# Pentagonal  P5,n=n(3n-1)/2  1, 5, 12, 22, 35, ...
# Hexagonal   P6,n=n(2n-1)    1, 6, 15, 28, 45, ...
# Heptagonal  P7,n=n(5n-3)/2  1, 7, 18, 34, 55, ...
# Octagonal   P8,n=n(3n-2)    1, 8, 21, 40, 65, ...

class Integer
  def is_quad?
    1000 <= self && self <= 9999 
  end

  def prefix
    @prefix ||= self / 100
  end

  def suffix 
    @suffix ||= self % 100
  end
end

class ShapeNumber
  attr_accessor :n, :quads, :quads_by_prefix, :quads_by_suffix

  def initialize(n)
    self.n = n
  end

  def self.generate
    list = []
    i = 1
    loop do
      shape = calculate(i)
      i += 1
      next if shape.n < 1000
      break if shape.n > 9999
      list << shape
    end
    list
  end

  def prefix
    n.prefix
  end

  def suffix
    n.suffix
  end

  protected
  def self.calculate(i)
    raise "must be implemented by subclasses"
  end

end

class Triangle < ShapeNumber
  def initialize(n); super(n); end
  def self.calculate(n); Triangle.new(n * (n+1) / 2); end
end

class Square < ShapeNumber
  def initialize(n); super(n); end
  def self.calculate(n); Square.new(n*n); end
end

class Pentagonal < ShapeNumber
  def initialize(n); super(n); end
  def self.calculate(n); Pentagonal.new(n*(3*n - 1) / 2); end
end

class Hexagonal < ShapeNumber
  def initialize(n); super(n); end
  def self.calculate(n); Hexagonal.new(n*(2*n - 1)); end
end

class Heptagonal < ShapeNumber
  def initialize(n); super(n); end
  def self.calculate(n); Heptagonal.new(n*(5*n - 3)/2); end
end

class Octagonal < ShapeNumber
  def initialize(n); super(n); end
  def self.calculate(n); Octagonal.new(n*(3*n-2)); end
end

class Chain < Struct.new(:triangle, :square, :pentagonal, :hexagonal, :heptagonal, :octagonal, :end, :start)
  attr_accessor :whole_chain

  def dup
    n = Chain.new
    n.triangle = triangle
    n.square = square
    n.pentagonal = pentagonal
    n.hexagonal = hexagonal
    n.heptagonal = heptagonal
    n.octagonal = octagonal
    n.whole_chain = whole_chain.dup
    n.start = start
    n.end = self.end
    n
  end

  def initialize
    self.whole_chain = []
  end

  def append n
    chain = self.dup
    chain.end = n
    chain.whole_chain << n

    if chain.start.nil?
      chain.start = n
    end

    chain.assign n
    chain
  end

  def prepend(n)
    chain = self.dup
    chain.start = n
    chain.whole_chain = [n] + chain.whole_chain

    if chain.end.nil?
      chain.end = n
    end

    chain.assign n
    chain
  end

  def assign(n)
    case n.class.name
    when Triangle.name
      self.triangle = n
    when Square.name
      self.square = n
    when Pentagonal.name
      self.pentagonal = n
    when Hexagonal.name
      self.hexagonal = n
    when Heptagonal.name
      self.heptagonal = n
    when Octagonal.name
      self.octagonal = n
    else
      raise "unrecognized shape #{n.inspect}, class #{n.class}"
    end
  end

  def has_triangle?
    triangle != nil
  end

  def has_square?
    square != nil
  end

  def has_pentagonal?
    pentagonal != nil
  end

  def has_hexagonal?
    hexagonal != nil
  end

  def has_heptagonal?
    heptagonal != nil
  end

  def has_octagonal?
    octagonal != nil
  end

  def is_complete?
    has_triangle? && 
      has_square? &&
      has_pentagonal? &&
      has_hexagonal? &&
      has_heptagonal? &&
      has_octagonal?
  end

  def to_s
    whole_chain.map{|shape| shape.n }.join(', ')
  end
end

class Problem
  attr_accessor :triangles, :squares, :pentagonals, :hexagonals, :heptagonals, :octagonals, :shapes

  def initialize
  end


  def solve
    self.triangles = Triangle.generate
    self.squares = Square.generate
    self.pentagonals = Pentagonal.generate
    self.hexagonals = Hexagonal.generate
    self.heptagonals = Heptagonal.generate
    self.octagonals = Octagonal.generate

    chain = find_partial_solution(Chain.new)
    puts chain
    puts chain.whole_chain.inject(0){ |sum,shape| sum += shape.n }
  end

  def find_partial_solution(chain)

    if chain.is_complete?
      # here we have a complete chain of all six kinds of shape
      # if it connects to itself in a circle then we have a solution.  
      return chain if chain.end.suffix == chain.start.prefix

      # otherwise, it's a dead end, move on.
      return nil
    end
    
    # here we have a partial chain.  Try to extend it by connecting things
    # to the front or the back, then recursing. 

    [ [:triangle, :has_triangle?, proc { triangles } ],
      [:square, :has_square?, proc { squares } ],
      [:pentagonal, :has_pentagonal?, proc { pentagonals } ],
      [:hexagonal, :has_hexagonal?, proc { hexagonals } ],
      [:heptagonal, :has_heptagonal?, proc { heptagonals } ],
      [:octagonal, :has_octagonal?, proc { octagonals } ],
    ].each do |shape_kind, has_shape, shapes_proc|
      next if chain.send(has_shape)

      shapes = shapes_proc.call

      # find shapes of this kind that can go on the end of the chain.  
      possible_ends = chain.end.nil? ? shapes : shapes.select {|shape| shape.prefix == chain.end.suffix }
      possible_ends.each do |new_end|

        # chain them on the end and recurse
        s = find_partial_solution(chain.append(new_end))

        # if it is not nil, we have our solution and can quit. 
        return s unless s.nil?
      end

      shapes.select {|shape| shape.suffix == chain.start.prefix }.each do |new_start|
        s = find_partial_solution(chain.prepend(new_start))
        return s unless s.nil?
      end
    end

    # here we failed to extend this chain, or all the extensions weren't solutions either.  
    nil
  end
end

Problem.new.solve
