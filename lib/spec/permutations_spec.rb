require 'permutations'

describe Permutations do

  it "should error if the list is missing" do
    lambda{Permutations.of(nil, 2)}.should raise_error('The list is nil')
  end

  it "should error if the permutation size is bigger than the list size" do
    lambda{Permutations.of(['a'], 2)}.should raise_error('There are not that many items in the list')
  end

  it "should error if the permutation size is negative" do
    lambda{Permutations.of(['a'], -1)}.should raise_error('Cannot pick -1 items from a list')
  end

  let(:empty_list) { [] }
  let(:one_element) { [ 'a' ] }
  let(:two_elements) { [ 'a', 'b' ] }
  let(:three_elements) { [ 'a', 'b', 'c' ] }
  let(:four_elements) { [ 'a', 'b', 'c', 'd' ] }

  context "of an empty list" do
    it 'should be empty for size 0' do
      Permutations.of([], 0).should == []
    end
  end

  context "of a 1 element list" do
    it "should be empty for size 0" do
      Permutations.of(one_element, 0).should == []
    end

    it "should have one permutation of size 1" do
      Permutations.of(one_element, 1).should == [ ['a'] ]
    end
  end

  context "of a 2 element list" do
    it "should have 2 permutations of size 1" do
      Permutations.of(two_elements, 1).should == [ ['a'], ['b'] ]
    end

    it "should have one permutation of size 2" do
      Permutations.of(two_elements, 2).should == [ [ 'a', 'b' ]]
    end
  end

  context "of a 3 element list" do
    it "should have 3 permutations of size 1" do
      Permutations.of(three_elements, 1).should == [ ['a'], ['b'], ['c'] ]
    end

    it "should have 3 permutations of size 2" do
      Permutations.of(three_elements, 2).should == [ ['a','b'], ['a','c'], ['b', 'c'] ]
    end

    it "should have 1 permutation of size 3" do
      Permutations.of(three_elements, 3).should == [ ['a','b','c']]
    end
  end

  context "of a 4 element list" do
    it "should have 4 permutations of size 1" do
      Permutations.of(four_elements, 1).should == [ ['a'], ['b'], ['c'], ['d'] ]
    end

    it "should have six two-element permutations" do
      Permutations.of(four_elements, 2).should == [ ['a','b'], ['a','c'], ['a','d'], ['b','c'], ['b','d'], ['c','d']]
    end

    it "should have four three-element permutations" do
      Permutations.of(four_elements, 3).should == [['a','b','c'], ['a','b','d'], ['a','c','d'], ['b','c','d']]
    end
  end

end
