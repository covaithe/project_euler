

require_relative '../hand.rb'
require_relative '../rflush_decider.rb'

describe "RFlush decider" do
  
  it "should pick a royal flush over another hand" do
    a = Hand.new("AS KS QS JS TS")
    b = Hand.new("AS AC QS JS TS")
    RFlushDecider.choose_winner(a, b).should == a
  end

  it "should pick a royal flush in the second hand over another hand" do 
    a = Hand.new("AS KS QS JS TS")
    b = Hand.new("AS AC QS JS TS")
    RFlushDecider.choose_winner(b, a).should == a
  end

  it "should return nil when neither hand is a royal flush" do
    a = Hand.new("AS KC QS JS TS")
    b = Hand.new("AS AC QS JS TS")
    RFlushDecider.choose_winner(b, a).should == nil
  end

end
