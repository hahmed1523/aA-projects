# == Schema Information
#
# Table name: goals
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  details    :string           not null
#  private    :boolean          default(FALSE), not null
#  completed  :boolean          default(FALSE), not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Goal, type: :model do

  describe 'validations' do 

    #Validation presence
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:details) }
    it { should validate_presence_of(:user_id) }

    #Validates booleans
    it { is_expected.not_to allow_value(nil).for(:private) }
    it { is_expected.not_to allow_value(nil).for(:completed) }
  end

  describe 'associations' do 

    it { should belong_to(:user) }

  end

  describe 'class methods' do 

    describe "set_defaults" do
      let(:goal) { Goal.new(private: nil, completed: nil) } 
      it 'sets the value to false if nil' do 
        expect(goal.private.nil?).to eq(false)
        expect(goal.completed.nil?).to eq(false)
      end
    end

    describe "privatize!" do
      let(:user) { FactoryBot.create(:user) }
      let(:goal) { FactoryBot.create(:goal, user_id: user.id) }

      it 'changes the private field from false to true' do 
        expect(goal.private).to eq(false)
        goal.privatize!
        expect(goal.private).to eq(true)
      end
      
    end

    describe "complete!" do
      let(:user) { FactoryBot.create(:user) }
      let(:goal) { FactoryBot.create(:goal, user_id: user.id) }

      it 'changes the completed field from false to true' do 
        expect(goal.completed).to eq(false)
        goal.complete!
        expect(goal.completed).to eq(true)
      end
      
    end

  end
  
end
