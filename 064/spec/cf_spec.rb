require_relative '../lib/cf'

describe ContinuedFraction do
  

  describe "from_sqrt" do

    context "2" do
      subject { ContinuedFraction.from_sqrt(2) }

      it { subject.m(0).should == 0 }
      it { subject.d(0).should == 1 }
      it { subject.a(0).should == 1 }

      it { subject.m(1).should == 1 }
      it { subject.d(1).should == 1 }
      it { subject.a(1).should == 2 }

      it { subject.m(2).should == 1 }
      it { subject.d(2).should == 1 }
      it { subject.a(2).should == 2 }

      it { subject.period.should == 1 }
    end

    context "3" do
      subject { ContinuedFraction.from_sqrt(3) }

      it { subject.m(0).should == 0 }
      it { subject.d(0).should == 1 }
      it { subject.a(0).should == 1 }

      it { subject.m(1).should == 1 }
      it { subject.d(1).should == 2 }
      it { subject.a(1).should == 1 }

      it { subject.m(2).should == 1 }
      it { subject.d(2).should == 1 }
      it { subject.a(2).should == 2 }

      it { subject.m(3).should == 1 }
      it { subject.d(3).should == 2 }
      it { subject.a(3).should == 1 }

      its(:period) { should == 2 }
    end

    context "5" do
      subject { ContinuedFraction.from_sqrt(5) }

      it { subject.m(0).should == 0 }
      it { subject.d(0).should == 1 }
      it { subject.a(0).should == 2 }

      it { subject.m(1).should == 2 }
      it { subject.d(1).should == 1 }
      it { subject.a(1).should == 4 }

      it { subject.m(2).should == 2 }
      it { subject.d(2).should == 1 }
      it { subject.a(2).should == 4 }
      
      its(:period) { should == 1 }
    end

    context "23" do
      subject { ContinuedFraction.from_sqrt(23) }

      it { subject.m(0).should == 0 }
      it { subject.d(0).should == 1 }
      it { subject.a(0).should == 4 }

      it { subject.m(1).should == 4 }
      it { subject.d(1).should == 7 }
      it { subject.a(1).should == 1 }

      it { subject.a(2).should == 3 }
      it { subject.a(3).should == 1 }
      it { subject.a(4).should == 8 }
      it { subject.a(5).should == 1 }
      it { subject.a(6).should == 3 }
      it { subject.a(7).should == 1 }
      it { subject.a(8).should == 8 }

      its(:period) { should == 4 }
    end

  end

end
