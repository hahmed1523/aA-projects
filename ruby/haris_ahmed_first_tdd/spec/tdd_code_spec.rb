require 'rspec'
require 'tdd_code'

describe '#my_unique' do
    it 'raise error is the argument is not an Array' do
        expect{ my_unique(3) }.to raise_error('This is not an Array!')
    end

    it 'removes duplicates' do
        expect(my_unique([1,2,2])).to eq([1,2])
    end
end

describe Array do

    describe '#two_sum' do
        it 'returns pairs of positions where elements sum to zero' do
            expect([-1,0,2,-2,1].two_sum).to eq([[0,4], [2,3]])
        end
    end
end

describe '#my_transpose' do
    it 'convert between the row-oriented and column-oriented representations' do
        expect(my_transpose([[0,1,2], [3,4,5], [6,7,8]])).to eq([[0,3,6], [1,4,7],[2,5,8]])
    end
end

describe "pick_stocks" do
    it "finds a simple pair" do
      expect(pick_stocks([3, 1, 0, 4, 6, 9])).to eq([2, 5])
    end
  
    it "finds a better pair after an inferior pair" do
      expect(pick_stocks([3, 2, 5, 0, 6])).to eq([3, 4])
    end
  
    it "does not buy stocks in a crash" do
      expect(pick_stocks([5, 4, 3, 2, 1])).to be_nil
    end
  end