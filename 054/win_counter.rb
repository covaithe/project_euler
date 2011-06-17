

require_relative "./hand.rb"
require_relative "./rflush_decider.rb"

games = File.readlines("poker.txt").map do |line|
  a = line[0,14] 
  # puts "hand a is #{a}"
  [ Hand.new(a), Hand.new( line[15,14] ) ]
end

n = 0
sum = 0
games.inject do |sum, game| 
  a = game[0]
  b = game[1]
  n += 1
  # puts "game #{n}, #{a} vs #{b}"
  sum += 1 if RFlushDecider.choose_winner(a, b) == a
end

puts sum
