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