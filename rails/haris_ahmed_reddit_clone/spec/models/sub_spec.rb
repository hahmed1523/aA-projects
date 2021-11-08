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
    subject { FactoryBot.create(:sub, moderator_id: user.id) }
    it { should validate_uniqueness_of(:title)}


  end

  describe 'associations' do 
    it { should belong_to(:moderator) }
    it { should have_many(:post_subs)}
    it { should have_many(:posts) }
  end

end
