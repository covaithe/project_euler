
require_relative '../card.rb'

describe "Card" do 
  context "AS" do
    it "should have A for rank" do
      Card.new("AS").rank.should == 'A'
    end

    it "should have S for suit" do
      Card.new("AS").suit.should == 'S'
    end
  end

  it "should have sequential numerical ranks" do
    Card.new("3D").numerical_rank.should == 1+Card.new("2D").numerical_rank
    Card.new("4D").numerical_rank.should == 1+Card.new("3D").numerical_rank
    Card.new("5D").numerical_rank.should == 1+Card.new("4D").numerical_rank
    Card.new("6D").numerical_rank.should == 1+Card.new("5D").numerical_rank
    Card.new("7D").numerical_rank.should == 1+Card.new("6D").numerical_rank
    Card.new("8D").numerical_rank.should == 1+Card.new("7D").numerical_rank
    Card.new("9D").numerical_rank.should == 1+Card.new("8D").numerical_rank
    Card.new("TD").numerical_rank.should == 1+Card.new("9D").numerical_rank
    Card.new("JD").numerical_rank.should == 1+Card.new("TD").numerical_rank
    Card.new("QD").numerical_rank.should == 1+Card.new("JD").numerical_rank
    Card.new("KD").numerical_rank.should == 1+Card.new("QD").numerical_rank
    Card.new("AD").numerical_rank.should == 1+Card.new("KD").numerical_rank
  end

end
