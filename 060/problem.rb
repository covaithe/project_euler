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
    self.primes_that_pair_with = {}
    self.triples = []
    self.quads = []
  end

  attr_accessor :primes_that_pair_with, :triples, :quads

  def solve

    Primes.calculate_primes_to(100000)

    i = 1

    loop do
      i += 1
      p = Primes.known_primes[i]
      puts "Checking #{p}...."

      # find all primes lower than p that pair with it.  
      1.upto(i-1) do |j|
        q = Primes.known_primes[j]
        record_pair(p,q) if [p,q].meets_conditions?
      end

      p_pairs = primes_that_pair_with[p] || []

      # see if we can make a five out of p plus a quad. 
      answer = quads.find { |quad| combines_nicely_with?(p,quad) }
      if answer
        a = [p] + answer
        puts "#{a.inspect} ==> #{a.inject(&:+)}"
        break
      end

      #okay, try to make fours from this plus the triples. 
      triples.each do |triple|
        if combines_nicely_with?(p, triple)
          quads << [p] + triple
        end
      end

      # look for new triples.  A triple means something in p's pair list that pairs with another thing
      # in p's pair list. 
      p_pairs.each do |q|
        (primes_that_pair_with[q] || []).each do |r|
          triples << [p,q,r] if p_pairs.include?(r)
        end
      end
    end
  end

  def combines_nicely_with?(p, list)
    p_pairs = primes_that_pair_with[p]
    return false if p_pairs.nil?
    #puts "pairs for #{p} are #{p_pairs.inspect}"
    list.all? { |q| p_pairs.include?(q) }
  end

  def record_pair(p,q)
    a = primes_that_pair_with[p] ||= []
    a << q
  end

end

Problem.new.solve

