
require_relative '../hand.rb'

describe "Hand" do
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
    [ Hand.new("AS KS QS JS TS"),
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
    [ Hand.new("6S 2S 3S 4S 5S"),
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
    [ Hand.new("6S 6C 6D 6H 5S"),
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
    [ Hand.new("6S 6C 6D 8H 8S"),
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
    [ Hand.new("6S 7S 8S 2S 9S"),
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
    [ Hand.new("6S 7C 8S 9S TD"),
      Hand.new("9C TC JC QC KC"),
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
    [ Hand.new("6S 6C 6S 9S TD"),
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
    [ Hand.new("6S 6C 9S 9S TD"),
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
    [ Hand.new("6S 6C JS 9S TD"),
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
    [ [ Hand.new("AS KS QS JS TS"), "royal flush"],
      [ Hand.new("KS QS JS TS 9S"), "straight flush"],
      # [ Hand.new("KS KC KH KD 9S"), "four of a kind"],
    ].each do |hand, kind| 
      it "#{hand} should be a #{kind}" do
        hand.kind.should == kind
      end
    end
  end
  
end
