require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do 
    it { should validate_presence_of(:author) }
    it { should validate_presence_of(:post) }
    it { should validate_presence_of(:body) }

  end

  describe 'associations' do 
    it { should belong_to(:author) }
    it { should belong_to(:post) }
    it { should have_many(:child_comments) }
    it { should belong_to(:parent_comment).optional }
    it { should have_many(:user_votes) }
  end
end
