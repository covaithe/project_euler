

require_relative "./hand.rb"

games = File.readlines("poker.txt").map do |line|
  a = line[0,14] 
  # puts "hand a is #{a}"
  [ Hand.new(a), Hand.new( line[15,14] ) ]
end

n = 0
sum = 0
wins = []
games.each do |game|
  a = game[0]
  b = game[1]

  win = a.beats? b
  puts "#{a} #{win ? 'beats   ' : 'loses to'} #{b}:  #{a.kind_s} vs #{b.kind_s}"
  if win
    wins << game
  end
end

puts "wins:  #{wins.length}"
