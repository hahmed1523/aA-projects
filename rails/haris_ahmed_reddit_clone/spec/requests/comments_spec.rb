require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:post1) { FactoryBot.create(:post, author_id: user.id) }

  before do 
    allow_any_instance_of(CommentsController).to receive(:current_user).and_return(user)
  end

  describe "POST create" do 

    let(:valid_params) do 
      { 
        comment: {
          post_id: post1.id,
          body: "This is a comment!"
      } 
    }
    end

    it 'redirects to the post page where comment is located' do 
      expect{ post comments_path, params: valid_params}.to change(Comment, :count).by(+1)
      expect(response).to redirect_to(post_url(Comment.last.post_id))
    end

    it 'redirects to post page with error if not valid' do 
      post comments_path, params: { comment: { post_id: post1.id } }
      expect(flash[:errors]).to include('Body can\'t be blank')
      expect(response).to redirect_to(new_post_comment_url(post1.id))
    end
  end

  # describe 'GET #show' do 
  #   let(:comment1) { Comment.new(post_id: post1.id, body:"this is a comment") }

  #   it 'renders show template' do 
  #     get comment_url(comment1.id)
  #     expect(response).to render_template(:show)
  #   end
  # end
end
