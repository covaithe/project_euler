#!/usr/bin/env ruby

#$:.push(".")
require "test/unit"
require "../Primes"

class PrimesTests < Test::Unit::TestCase

  def test_prime_factorization_10
    f = Primes.factorize(10)
    assert_equal(2, f.length)
    assert_equal(2, f[0])
    assert_equal(5, f[1])
  end

  def test_prime_factorization_99
    f = Primes.factorize(99)
    assert_equal(3, f.length)
    assert_equal(3, f[0])
    assert_equal(3, f[1])
    assert_equal(11, f[2])
  end

  def test_prime_factorization_1001
    f = Primes.factorize(1001)
    assert_equal(3, f.length)
    assert_equal(7, f[0])
    assert_equal(11, f[1])
    assert_equal(13, f[2])
  end

  def test_prime_factorization_31
    f = Primes.factorize(31)
    assert_equal(1, f.length)
    assert_equal(31, f[0])
  end

  def test_exponent_vector_1
    vec = Primes.exponent_vector(1)
    assert_equal(0, vec.length)
  end

  def test_exponent_vector_1001
    vec = Primes.exponent_vector(1001)
    assert_equal(6, vec.length)
    assert_equal(0, vec[0]) # 2
    assert_equal(0, vec[1]) # 3
    assert_equal(0, vec[2]) # 5
    assert_equal(1, vec[3]) # 7
    assert_equal(1, vec[4]) # 11
    assert_equal(1, vec[5]) # 13
  end

  def test_exponent_vector_99
    vec = Primes.exponent_vector(99)
    assert_equal(5, vec.length)
    assert_equal(0, vec[0]) # 2
    assert_equal(2, vec[1]) # 3
    assert_equal(0, vec[2]) # 5
    assert_equal(0, vec[3]) # 7
    assert_equal(1, vec[4]) # 11
  end

  def test_calc_primes_to_100
      Primes.calculate_primes_to(100)
      assert_equal(25, Primes.known_primes.length)
      assert_equal([2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97], Primes.known_primes)
  end

end
