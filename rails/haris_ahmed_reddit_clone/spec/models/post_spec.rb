# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :string
#  sub        :integer          not null
#  author     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Post, type: :model do

  let(:user) { FactoryBot.create(:user) }
  let(:sub) { FactoryBot.create(:sub, moderator_id: user.id) }
  describe 'validations' do 

    #Validating presence
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author) }

  end

  describe 'associations' do 
    it { should belong_to(:author) }
  end


end
