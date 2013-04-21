# The 5-digit number, 16807=7^5, is also a fifth power. Similarly, the 9-digit number, 134217728=8^9, is a ninth power.
#
# How many n-digit positive integers exist which are also an nth power?
#
# Idea:  10^2 == 100 has 3 digits.  for any n, 10^n has n+1 digits.  So only digits 1 through 9 can be roots
# of an nth power with n digits.  Also, at some point, 9^n will be less than 10^(n-1), i.e. will have less than n
# digits.  Then we can stop looking.

class Integer
  def digits
    to_s.size
  end
end

class Problem

  def solve
    count = 0
    p = 1

    while 9**p >= 10**(p-1)

      (1..9).each do |n|
        power = n**p
        digits = power.digits
        if digits == p
          puts "#{n}**#{p} == #{power} has #{digits} digits"
          count += 1
        end
      end
    
      p += 1
    end

    puts "total is #{count}"
  end
end

Problem.new.solve
