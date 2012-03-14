require_relative "./continued_fraction"

describe ContinuedFraction do

  it "first iteration should be 3/2" do
    fraction = ContinuedFraction.new(1)
    fraction.numerator.should == 3
    fraction.denominator.should == 2
  end

  it "second iteration should be 7/5" do
    fraction = ContinuedFraction.new(2)
    fraction.numerator.should == 7
    fraction.denominator.should == 5
  end

  it "third iteration should be 17/12" do
    fraction = ContinuedFraction.new(3)
    fraction.numerator.should == 17
    fraction.denominator.should == 12
  end
end
