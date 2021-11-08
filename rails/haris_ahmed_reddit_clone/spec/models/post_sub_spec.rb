require 'rails_helper'

RSpec.describe PostSub, type: :model do
  let(:user1) { FactoryBot.create(:user) }
  let(:sub1) { FactoryBot.create(:sub, moderator: user1) }
  let(:sub2) { FactoryBot.create(:sub, moderator: user1) }
  let(:post1) { FactoryBot.create(:post, author_id: user1.id) }

  describe 'validations' do 

    it { should validate_presence_of(:post_id) }
    it { should validate_presence_of(:sub_id) }

    subject { PostSub.new(post_id: post1.id, sub_id: sub1.id) }
    it { should validate_uniqueness_of(:post_id).scoped_to(:sub_id) }

  end

end
