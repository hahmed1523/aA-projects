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