require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:post1) { FactoryBot.create(:post, author_id: user.id) }

  before do 
    allow_any_instance_of(PostsController).to receive(:current_user).and_return(user)
  end

  describe "GET #show" do 
    it 'renders the show template' do 
      get post_path(post1)
      expect(response).to render_template(:show)
    end

    context 'if the post does not exist' do 
      it 'is not a success' do 
        get post_path(-1)
        expect(flash[:errors]).to include("Post is not found")
        expect(response).to redirect_to(:root)
      end
    end
  end

  describe "GET #new" do 
    it 'render new template' do 
      get new_post_path
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do 
    it 'redirects to the post page' do 
      post posts_path, params: { post: {title: 'post_title', url: 'post_url', content: 'content'}}
      expect(response).to redirect_to(post_url(Post.last))
    end
  end
end
