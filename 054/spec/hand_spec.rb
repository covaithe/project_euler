
require_relative '../hand.rb'

describe "Hand" do
  royal_flush = Hand.new("AS KS QS JS TS")
  straight_flush = Hand.new("6S 2S 3S 4S 5S")
  four_of_a_kind = Hand.new("6S 6C 6D 6H 5S")
  full_house = Hand.new("6S 6C 6D 8H 8S")
  flush = Hand.new("6S 7S 8S 2S 9S")
  straight = Hand.new("6S 7C 8S 9S TD")
  three_of_a_kind = Hand.new("6S 6C 6S 9S TD")
  two_pair = Hand.new("6S 6C 9S 9S TD")
  one_pair = Hand.new("6S 6C JS 9S TD")
  high_card = Hand.new("2C 9D TC JS QD")
   

  context "AS KS QS JS TS" do
    before(:each) do
      @hand = Hand.new("AS KS QS JS TS")
    end
  
    it "should have five cards" do
      @hand.cards.length.should == 5
    end

    it "should remember its original string form" do
      @hand.to_s.should == "AS KS QS JS TS"
    end
  
    it "should have the ace of spades" do
      @hand.cards.any?{ |c| c.rank == 'A' && c.suit == 'S' }.should be_true
    end
  end


  context "royal flush" do
    [ royal_flush,
      Hand.new("KS AS QS JS TS"),
    ].each do |hand| 
      it "#{hand} should be a royal flush" do
        hand.should be_royal_flush
      end
    end
  
    [ Hand.new("5S KS QS JS TS"),
      Hand.new("5S AS QS JS TS"),
      Hand.new("AC KS QS JS TS"),
      Hand.new("AS KC QS JS TS"),
      Hand.new("AS KS QC JS TS"),
      Hand.new("AS KS QS JC TS"),
      Hand.new("AS KS QS JS TC"),
    ].each do |hand| 
      it "#{hand} should not be a royal flush" do
        hand.should_not be_royal_flush
      end
    end
  end

  context "straight flush" do
    [ straight_flush,
    ].each do |hand| 
      it "#{hand} should be a straight flush" do
        hand.should be_straight_flush
      end
    end
  
    [ Hand.new("6C 2S 3S 4S 5S"),
      Hand.new("6S 3S 3S 4S 5S"),
    ].each do |hand| 
      it "#{hand} should not be a straight flush" do
        hand.should_not be_straight_flush
      end
    end
  end
  
  context "four of a kind" do
    [ four_of_a_kind,
      Hand.new("AS AC AD AH 5S"),
    ].each do |hand| 
      it "#{hand} should be four of a kind" do
        hand.should be_four_of_a_kind
      end
    end
  
    [ Hand.new("6S 6C 6D 4H 4S"),
      # Hand.new("AS AC AD AH 5S"),
    ].each do |hand| 
      it "#{hand} should not be four of a kind" do
        hand.should_not be_four_of_a_kind
      end
    end
  end
  
  context "full house" do
    [ full_house,
      Hand.new("AS AC AD KH KS"),
    ].each do |hand| 
      it "#{hand} should be full house" do
        hand.should be_full_house
      end
    end
  
    [ Hand.new("6S 6C 6D 7H 4S"),
      Hand.new("6S 6C 7D 7H 4S"),
    ].each do |hand| 
      it "#{hand} should not be full house" do
        hand.should_not be_full_house
      end
    end
  end

  context "flush" do
    [ flush,
      Hand.new("AC 3C JC KC QC"),
    ].each do |hand| 
      it "#{hand} should be flush" do
        hand.should be_flush
      end
    end
  
    [ Hand.new("6S 6C 6D 7H 4S"),
      Hand.new("6S 8S 7S 7H 4S"),
    ].each do |hand| 
      it "#{hand} should not be flush" do
        hand.should_not be_flush
      end
    end
  end
  
  context "straight" do
    [ straight,
      Hand.new("9C TC JC QS KC"),
    ].each do |hand| 
      it "#{hand} should be straight" do
        hand.should be_straight
      end
    end
  
    [ Hand.new("6S 6C 6D 7H 4S"),
      Hand.new("6S 8S 7S 7H 4S"),
    ].each do |hand| 
      it "#{hand} should not be straight" do
        hand.should_not be_straight
      end
    end
  end
  
  context "three of a kind" do
    [ three_of_a_kind,
      Hand.new("9C 9C 9C QC KC"),
    ].each do |hand| 
      it "#{hand} should be three of a kind" do
        hand.should be_three_of_a_kind
      end
    end
  
    [ Hand.new("6S 6C 7D 7H 4S"),
      Hand.new("6S 8S 7S 7H 4S"),
    ].each do |hand| 
      it "#{hand} should not be three_of_a_kind" do
        hand.should_not be_three_of_a_kind
      end
    end
  end
  
  context "two pair" do
    [ two_pair,
      Hand.new("9C 9C QC QC KC"),
    ].each do |hand| 
      it "#{hand} should be two pair" do
        hand.should be_two_pair
      end
    end
  
    [ Hand.new("6S 6C 7D 8H 4S"),
      Hand.new("6S 8S 7S 9H 4S"),
    ].each do |hand| 
      it "#{hand} should not be two_pair" do
        hand.should_not be_two_pair
      end
    end
  end
  
  context "one pair" do
    [ one_pair,
      Hand.new("9C 9C AC QC KC"),
    ].each do |hand| 
      it "#{hand} should be one pair" do
        hand.should be_one_pair
      end
    end
  
    [ Hand.new("6S 9C 7D 8H 4S"),
      Hand.new("6S 8S 7S 9H 4S"),
    ].each do |hand| 
      it "#{hand} should not be one pair" do
        hand.should_not be_one_pair
      end
    end
  end

  context "should know what kind of hand it is" do 
    [ [ royal_flush, Hand::ROYAL_FLUSH],
      [ straight_flush, Hand::STRAIGHT_FLUSH],
      [ four_of_a_kind, Hand::FOUR_OF_A_KIND],
      [ full_house, Hand::FULL_HOUSE ],
      [ flush, Hand::FLUSH ],
      [ straight, Hand::STRAIGHT ],
      [ three_of_a_kind, Hand::THREE_OF_A_KIND ],
      [ two_pair, Hand::TWO_PAIR ],
      [ one_pair, Hand::ONE_PAIR ],
      [ high_card, Hand::HIGH_CARD ],
    ].each do |hand, kind| 
      it "#{hand} should be a #{kind}" do
        hand.kind.should == kind
      end
    end
  end

  RSpec::Matchers.define :beat do |otherhand|
    match do |hand|
      hand.beats? otherhand
    end

    failure_message_for_should do |hand|
      "#{hand} should have beat #{otherhand} but did not"
    end
  end

  context "should be able to tell if one hand beats another" do
    it "Royal flush should beat high card" do
      royal_flush.should beat high_card
      high_card.should_not beat royal_flush
    end
    it "royal flush should beat one pair" do
      royal_flush.should beat one_pair
      one_pair.should_not beat royal_flush
    end
    it "royal flush should beat two pair" do
      royal_flush.should beat two_pair
      two_pair.should_not beat royal_flush
    end
    it "royal flush should beat three of a kind" do
      royal_flush.should beat three_of_a_kind
      three_of_a_kind.should_not beat royal_flush
    end
    it "royal flush should beat straight" do
      royal_flush.should beat straight
      straight.should_not beat royal_flush
    end
    it "royal flush should beat flush" do
      royal_flush.should beat flush
      flush.should_not beat royal_flush
    end
    it "royal flush should beat full house" do
      royal_flush.should beat full_house
      full_house.should_not beat royal_flush
    end
    it "royal flush should beat four of a kind" do
      royal_flush.should beat four_of_a_kind
      four_of_a_kind.should_not beat royal_flush
    end
    it "royal flush should beat straight flush" do
      royal_flush.should beat straight_flush
      straight_flush.should_not beat royal_flush
    end
    it "royal flush should not beat royal flush" do
      a = Hand.new("AS KS QS JS TS")
      b = Hand.new("AH KH QH JH TH")
      a.should_not beat b
      b.should_not beat a
    end

    it "straight flush should beat four of a kind" do
      straight_flush.should beat four_of_a_kind
      four_of_a_kind.should_not beat straight_flush
    end
    it "straight flush should beat full house" do
      straight_flush.should beat full_house
      full_house.should_not beat straight_flush
    end
    it "straight flush should beat flush" do
      straight_flush.should beat flush
      flush.should_not beat straight_flush
    end
    it "straight flush should beat straight" do
      straight_flush.should beat straight
      straight.should_not beat straight_flush
    end
    it "straight flush should beat three of a kind" do
      straight_flush.should beat three_of_a_kind
      three_of_a_kind.should_not beat straight_flush
    end
    it "straight flush should beat two pair" do
      straight_flush.should beat two_pair
      two_pair.should_not beat straight_flush
    end
    it "straight flush should beat one pair" do
      straight_flush.should beat one_pair
      one_pair.should_not beat straight_flush
    end
    it "straight flush should beat high card" do
      straight_flush.should beat high_card
      high_card.should_not beat straight_flush
    end
    it "between two straight flushes the high card should win" do
      a = Hand.new("2S 3S 4S 5S 6S")
      b = Hand.new("4H 5H 6H 7H 8H")

      a.should_not beat b
      b.should beat a
    end

    it "pair jacks should beat pair threes even if the latter has king high" do
      a = Hand.new("JH JS 2H 3H 4H")
      b = Hand.new("3S 3C KS JH QH")

      a.should beat b
      b.should_not beat a
    end
    
  end

end
