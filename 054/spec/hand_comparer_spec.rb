
require_relative '../hand_comparer.rb'

describe "HandComparer" do
  before(:each) do
    @comparer = HandComparer.new
  end

  it "should pick a royal flush over a straight flush" do
    hand1 = Hand.new("AS KS QS JS TS")
    hand2 = Hand.new("KS QS JS TS 9S") 
    @comparer.pick_winner(hand1, hand2).should == 1
  end
  
  it "should pick a straight flush over a four of a kind" do
    hand1 = Hand.new("AS AC AH AD TS")
    hand2 = Hand.new("KS QS JS TS 9S") 
    @comparer.pick_winner(hand1, hand2).should == 2
  end
  
  it "should pick a four of a kind over a full house" do
    hand1 = Hand.new("AS AC AH AD TS")
    hand2 = Hand.new("KS KC JS JH JD") 
    @comparer.pick_winner(hand1, hand2).should == 1
  end
  
  it "should pick a full house over a flush" do
    hand1 = Hand.new("AS 2S 5S 3S TS")
    hand2 = Hand.new("KS KC JS JH JD") 
    @comparer.pick_winner(hand1, hand2).should == 2
  end
  
  it "should pick a flush over a straight" do
    hand1 = Hand.new("AS 2S 5S 3S TS")
    hand2 = Hand.new("KS QC JS TH 9D") 
    @comparer.pick_winner(hand1, hand2).should == 1
  end
  
  it "should pick a straight over a three of a kind" do
    hand1 = Hand.new("AS AC AH KD TS")
    hand2 = Hand.new("KS QC JS TH 9D") 
    @comparer.pick_winner(hand1, hand2).should == 2
  end
  
  it "should pick a three of a kind over two pair" do
    hand1 = Hand.new("AS AC AH KD TS")
    hand2 = Hand.new("KS KC JS JH 9D") 
    @comparer.pick_winner(hand1, hand2).should == 1
  end
  
  it "should pick two pair over one pair" do
    hand1 = Hand.new("AS AC JH KD TS")
    hand2 = Hand.new("KS KC JS JH 9D") 
    @comparer.pick_winner(hand1, hand2).should == 2
  end
  
end
