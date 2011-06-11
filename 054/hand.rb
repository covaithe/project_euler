require_relative './card.rb'

class Hand

  attr_reader :cards, :kind

  def initialize(str)
    @str = str
    @cards = str.split.map {|c| Card.new(c) }

    compute_count_by_rank
    decide_kind

    
  end

  def decide_kind
    if royal_flush?
      @kind = "royal flush"
    else
      @kind = "straight flush"
    end
  end

  def compute_count_by_rank
    @count_by_rank = { }
    cards.each do |c| 
      if @count_by_rank[c.rank] == nil
        @count_by_rank[c.rank] = 0
      end
      @count_by_rank[c.rank] += 1
    end
  end

  def to_s
    @str
  end

  def royal_flush?
    return straight_flush? && cards.map(&:rank).include?('A')
  end

  def straight_flush?
    return flush? && straight?
  end

  def four_of_a_kind?
    return @count_by_rank.values.any? { |x| x == 4 }
  end

  def three_of_a_kind?
    return @count_by_rank.values.any? { |x| x == 3 }
  end

  def two_pair?
    return @count_by_rank.values.sort == [ 1, 2, 2]
  end

  def one_pair?
    return @count_by_rank.values.sort == [ 1, 1, 1, 2]
  end

  def full_house?
    return @count_by_rank.values.sort == [2,3]
  end

  def flush?
    suit = cards[0].suit
    return false if suit != cards[1].suit
    return false if suit != cards[2].suit
    return false if suit != cards[3].suit
    return false if suit != cards[4].suit
    return true
  end

  def straight?
    ranks = cards.map { |c| c.numerical_rank }.sort
    return ranks[0] + 1 == ranks[1] &&
        ranks[1] + 1 == ranks[2] &&
        ranks[2] + 1 == ranks[3] &&
        ranks[3] + 1 == ranks[4]
  end

end



