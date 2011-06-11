
class Card
  attr_accessor :rank, :suit

  def initialize(characters)
    self.rank = characters[0,1]
    self.suit = characters[1,1]
  end

  def numerical_rank
    return 14 if rank == 'A'
    return 10 if rank == 'T'
    return 11 if rank == 'J'
    return 12 if rank == 'Q'
    return 13 if rank == 'K'
    return rank.to_i
  end
end
