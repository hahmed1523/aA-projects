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
    it { should have_many(:post_subs)}
    it { should have_many(:subs) }
    it { should have_many(:comments) }
  end


  describe 'class methods' do 
    let(:post1) { Post.create(title: "Post1", content: "this is content", author_id: user.id) }

    describe 'comments_by_parent' do 

        let!(:parent_comment1) { Comment.create(user_id: user.id, post_id: post1.id, 
          body: "this is parent1 comment", parent_comment_id: nil) }
        
        let!(:parent_comment2) { Comment.create(user_id: user.id, post_id: post1.id, 
          body: "this is parent2 comment", parent_comment_id: nil)}

        let!(:cc_p1) { Comment.create(user_id: user.id, post_id: post1.id, 
          body: "this is child1 for parent1 comment", parent_comment_id: parent_comment1.id)}
        

      it 'should return a hash of all the posts comments with the key being the parent_comment _id' do    

        expect(post1.comments_by_parent[nil].length).to eq(2)
        expect(post1.comments_by_parent[parent_comment1.id].length).to eq(1)

      end
    end
  end


end
