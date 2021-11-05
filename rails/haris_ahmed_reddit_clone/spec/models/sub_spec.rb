# == Schema Information
#
# Table name: subs
#
#  id          :bigint           not null, primary key
#  title       :string           not null
#  description :string           not null
#  moderator   :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Sub, type: :model do

  let(:user) { FactoryBot.create(:user) }
  
  describe 'validations' do 


    #Validating presence
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:moderator) }

    # #Validating uniqueness
    subject { FactoryBot.create(:sub, moderator: user.id) }
    it { should validate_uniqueness_of(:title).scoped_to(:moderator) }


  end

  describe 'associations' do 
    it { should belong_to(:moderator_a) }
    it { should have_many(:posts) }
  end

end
