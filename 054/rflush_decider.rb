
class RFlushDecider
  
  def self.choose_winner(a, b)
    return a if a.royal_flush?
    return b if b.royal_flush?
  end
end
