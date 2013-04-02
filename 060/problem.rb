# The primes 3, 7, 109, and 673, are quite remarkable. By taking any two 
# primes and concatenating them in any order the result will always be prime. 
# For example, taking 7 and 109, both 7109 and 1097 are prime. The sum of 
# these four primes, 792, represents the lowest sum for a set of four primes 
# with this property.
#
# Find the lowest sum for a set of five primes for which any two primes 
# concatenate to produce another prime.

require_relative '../lib/Primes.rb'
require_relative '../lib/permutations'

module Enumerable
  def pairs
    r = []
    a = self
    0.upto(length-2).each do |i|
      (i+1).upto(length-1).each do |j|
        r << [ a[i], a[j] ]
      end
    end
    r
  end

  def numcat
    join('').to_i
  end

  def pairwise_concatenations
    p = pairs
    forwards = p.map(&:numcat)
    backwards = p.map(&:reverse).map(&:numcat)
    forwards.concat(backwards)
  end

  def meets_conditions?
    pairwise_concatenations.all? {|n| n.is_prime?}
  end
end

class Cluster
  def initialize
    self.primes = []
  end

  def <<(pair)
    self.pairs << pair
  end

  def to_s
    "[" + pairs.map(&:to_s).join(',') + "]"
  end
end

class Integer
  def is_prime?
    i = 0
    limit = Math.sqrt(self).ceil
    Primes.calculate_primes_to(limit)
    loop do
      d = Primes.known_primes[i]
      break if d > limit
      return false if self % d == 0
      i += 1
    end
    true
  end
end

class Problem

  def initialize
    @p_index = 1
    @q_index = 0
    self.known_pairs = []
    self.primes_that_pair_with = {}
  end

  attr_accessor :p, :q, :p_index, :q_index, :known_pairs, :primes_that_pair_with

  def solve

    Primes.calculate_primes_to(100000)

    count = 0
    loop do
      count += 1
      pair = choose_next_primes

      next unless pair.ok?
      append_pair(pair)
      #puts primes_that_pair_with.inspect if count % 1000 == 0

      break if check_for_answer pair
    end

    stuff = [1, 2, 3, 4]
    sample = [ 3, 7, 109, 673 ]

    #puts stuff.meets_conditions?
    #puts sample.meets_conditions?

    indices = [0, 1, 2, 3, 4]

  end

  def append_pair pair
    a = primes_that_pair_with[pair.a] ||= []
    a << pair.b
  end

  def choose_next_primes
    self.q_index += 1
    print = false
    if q_index == p_index
      self.p_index += 1
      self.q_index = 1
      print = true
    end

    p = Primes.known_primes[p_index]
    q = Primes.known_primes[q_index]

    if print
      puts "Checking #{p}..."
    end
    PrimePair.new(p, q)
  end

  COUNT = 5

  def check_for_answer pair
    # our chain of pairwise primes consists of pair.a, pair.b, and 3 other things
    # which have to be found in primes_that_pair_with[pair.b].  We check the 
    # smallest things in that list first. 

    pwb = primes_that_pair_with[pair.b]
    return false if pwb.nil?
    candidates = pwb.reverse
    return false if candidates.size < COUNT - 2
    
    Permutations.of(candidates, COUNT-2).each do |perm|
      x = pair.to_a.concat(perm)
      #puts "checking #{x.inspect}: #{x.meets_conditions?}"
      if meets_conditions?(x)
        puts "#{x.inspect} ==> #{x.inject(&:+)}"
        return true
      end
    end
    false
  end

  def meets_conditions?(list)
    # so we have a list like a,b,c,d,e.  We know that a pairs with b, and b pairs with 
    # c, d, and e.  
    a,b,c,d,e = *list
    a_pairs = primes_that_pair_with[a]
    return false unless a_pairs.include?(c)
    return false unless a_pairs.include?(d)
    return false unless a_pairs.include?(e)

    c_pairs = primes_that_pair_with[c]
    return false unless c_pairs.include?(d)
    return false unless c_pairs.include?(e)

    return primes_that_pair_with[d].include?(e)
  end

  def grow_cluster orig
    
    known_pairs.each do |pair|
      break if pair.a > orig.last
      next unless pair.a == orig.last
      puts "Considering #{orig} and #{pair}"
      #puts known_pairs.inspect
      c = orig.to_a.dup.concat(pair.to_a).uniq
      puts "#{c.inspect} ==> #{c.meets_conditions?}" if c.meets_conditions?
    end

  end

  PrimePair = Struct.new(:a, :b) do
    def to_s
      "[#{a}, #{b}]"
    end

    def to_a
      [ a, b ]
    end

    def last
      b
    end

    def ok?
      [a,b].meets_conditions?
    end
  end

end

Problem.new.solve

