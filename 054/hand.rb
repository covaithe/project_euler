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
      @kind = ROYAL_FLUSH
    elsif straight_flush?
      @kind = STRAIGHT_FLUSH
    elsif four_of_a_kind?
      @kind = FOUR_OF_A_KIND
    elsif full_house?
      @kind = FULL_HOUSE
    elsif flush?
      @kind = FLUSH
    elsif straight?
      @kind = STRAIGHT
    elsif three_of_a_kind?
      @kind = THREE_OF_A_KIND
    elsif two_pair?
      @kind = TWO_PAIR
    elsif one_pair?
      @kind = ONE_PAIR
    else
      @kind = HIGH_CARD
    end
  end

  def beats? other
    if kind == other.kind
      if card_rank_uses_all_cards
        return has_higher_high_card?(other) 
      else
        return has_higher_rank_cards?(other)
      end
    end

    kind > other.kind
  end

  def card_rank_uses_all_cards
    hands_with_junk_left_over = [ 
      ONE_PAIR, 
      TWO_PAIR, 
      THREE_OF_A_KIND, 
      FOUR_OF_A_KIND ]
    !hands_with_junk_left_over.include? kind
  end

  def has_higher_high_card?(other)
    ranks = cards.map(&:numerical_rank).sort.reverse
    other_ranks = other.cards.map(&:numerical_rank).sort.reverse
    compare_by_rank ranks, other_ranks
  end

  def has_higher_rank_cards?(other)
    ranks = ranks_with_multiple_cards
    other_ranks = other.ranks_with_multiple_cards
    compare_by_rank ranks, other_ranks
  end

  def ranks_with_multiple_cards
    byrank = { }
    cards.each do |c| 
      if byrank[c.numerical_rank] == nil
        byrank[c.numerical_rank] = 0
      end
      byrank[c.numerical_rank] += 1
    end
    byrank
      .select { |rank,count| rank > 1 }
      .sort_by { |rank,count| [ -count, -rank ] }
      .map { |rank,count| rank }
  end

  def compare_by_rank(ranks, other_ranks)
    (0..4).each do |i|
      return true if ranks[i] > other_ranks[i]
      return false if ranks[i] < other_ranks[i]
    end
    false
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

  def kind_s
    return "high card" if kind == HIGH_CARD
    return "one pair" if kind == ONE_PAIR
    return "two pair" if kind == TWO_PAIR
    return "three of a kind" if kind == THREE_OF_A_KIND
    return "straight" if kind == STRAIGHT
    return "flush" if kind == FLUSH
    return "four of a kind" if kind == FOUR_OF_A_KIND
    return "straight flush" if kind == STRAIGHT_FLUSH
    return "royal flush" if kind == ROYAL_FLUSH
  end

  HIGH_CARD = 1
  ONE_PAIR = 2
  TWO_PAIR = 3
  THREE_OF_A_KIND = 4
  STRAIGHT = 5
  FLUSH = 6
  FULL_HOUSE = 7
  FOUR_OF_A_KIND = 8
  STRAIGHT_FLUSH = 9
  ROYAL_FLUSH = 10 

end



