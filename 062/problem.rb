# The cube, 41063625 (345^3), can be permuted to produce two other cubes: 56623104 (384^3) 
# and 66430125 (405^3). In fact, 41063625 is the smallest cube which has exactly three 
# permutations of its digits which are also cube.
#
#  Find the smallest cube for which exactly five permutations of its digits are cube.
#
# Idea:  find the frequency distribution of digits of the cubes.  All of the above cubes
# have this digit frequency distribution:  0:1, 1:1, 2:1, 3:1, 4:1, 5:1, 6:2, 7:0, 8:0, 9:0.
# All permutations of a number will have the same frequency distribution, so just need to 
# calculate cubes, find each frequency distribution, and count cubes that have the same
# freq dist, until we find 5 cubes that have the same frequency distribution.  


class Integer
  def freq_dist
    hash = {}
    self.to_s.chars.each do |c|
      hash[c] = 0 unless hash.has_key?(c)
      hash[c] += 1
    end
    hash
  end
end

class Problem

  def solve
    #puts 12334.freq_dist.inspect
    #puts "#{12334.freq_dist == 31234.freq_dist}"
    #puts "#{12335.freq_dist == 31234.freq_dist}"

    cubes_by_dist = {}
    n = 1
    loop do 
      cube = n*n*n
      dist = cube.freq_dist
      list = cubes_by_dist[dist] ||= []
      list << cube
      puts "#{n}^3 = #{cube}:  #{dist.inspect} => #{list.inspect} has count #{list.size}"
      if list.size == 5
        puts list.min
        break
      end

      n += 1
    end
  end
end

Problem.new.solve
