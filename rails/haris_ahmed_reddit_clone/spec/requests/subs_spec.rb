require 'rails_helper'

RSpec.describe "Subs", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:sub) { FactoryBot.create(:sub, moderator_id: user.id) }

  before do 
    allow_any_instance_of(SubsController).to receive(:current_user).and_return(user)
  end

  describe "GET #index" do 
    it 'renders the subs index' do 
      get subs_path 
      expect(response).to be_success 
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do 
    it 'renders the show template' do 
      get sub_path(sub)
      expect(response).to render_template(:show)
    end

    context 'if the sub does not exist' do 
      it 'is not a success' do 
        get sub_path(-1)
        expect(flash[:errors]).to include("Sub is not found")
        expect(response).to redirect_to(:root)
      end
    end
  end

  describe "GET #new" do 
    it 'render new template' do 
      get new_sub_path
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do 
    let(:valid_params) do 
      {
        sub: {
          title: 'post_test',
          description: 'post_description'
        }
      }
    end

    let(:invalid_params) do 
      {
        sub: {
          description: 'post_description',
        }
      }
    end

    context 'valid params' do 

      it 'add new record to database' do 
        expect{ post subs_path, params: valid_params }.to change(Sub, :count).by(+1)
      end

      it 'redirects to sub page' do 
        post subs_path, params: valid_params
        expect(response).to redirect_to(sub_url(Sub.last))
      end
    end

    context 'invalid params' do 

      it 'does not add new record to database' do 
        expect{ post subs_path, params: invalid_params }.to change(Sub, :count).by(0)
      end

      it 'redirects to new view' do 
        post subs_path, params: invalid_params
        expect(response).to render_template(:new)
      end

      it 'has error in flash' do 
        post subs_path, params: invalid_params
        expect(flash[:errors]).to include("Title can't be blank")
      end
    end

  end

  describe "GET #edit" do 
    subject(:edit_sub) { FactoryBot.create(:sub, moderator_id: user.id) }

    it 'renders the edit template' do 
      get edit_sub_path(edit_sub)
      expect(response).to render_template(:edit)
    end

    context 'if the user does not exist' do 
      it 'is not a success' do 
        get edit_sub_path(-1)
        expect(flash[:errors]).to include("Forbidden: You are not the Moderator of Sub")
        expect(response).to redirect_to(:root)
      end
    end

    context 'if the user is not moderator then error' do 
      let(:user2) { FactoryBot.create(:user) }

      before do 
        allow_any_instance_of(SubsController).to receive(:current_user).and_return(user2)
      end

      it 'returns an error and redirects to root' do 
        get edit_sub_path(edit_sub)
        expect(flash[:errors]).to include("Forbidden: You are not the Moderator of Sub")
        expect(response).to redirect_to(:root)

      end
    end
  end

  describe 'PATCH #update' do 
    it 'successfully updates record' do 
      patch sub_url(sub), params: { sub: {title: 'patch_test'} }
      expect(response).to redirect_to(sub_url(user.subs.find_by(title: 'patch_test')))
    end

    it 'does not update the record' do 
      patch sub_url(sub), params: { sub: {title: ''} }
      expect(flash[:errors]).to include("Title can't be blank")
      expect(response).to render_template(:edit)
    end
  end

end
