require 'rails_helper'

RSpec.describe "Users", type: :request do

  let(:user) { FactoryBot.create(:user) }

  describe "GET #index" do 
    it 'renders the users index' do 
      get users_path 
      expect(response).to be_success 
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do 
    it 'renders the show template' do 
      get user_path(user)
      expect(response).to render_template(:show)
    end

    context 'if the user does not exist' do 
      it 'is not a success' do 
        get user_path(-1)
        expect(flash[:errors]).to include("User is not found")
        expect(response).to redirect_to(:root)
      end
    end
  end

  describe "GET #new" do 
    it 'render new template' do 
      get new_user_path
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do 
    let(:valid_params) do 
      {
        user: {
          username: 'post_test',
          password: 'password'
        }
      }
    end

    let(:invalid_params) do 
      {
        user: {
          username: 'post_test',
        }
      }
    end

    context 'valid params' do 

      it 'add new record to database' do 
        expect{ post users_path, params: valid_params }.to change(User, :count).by(+1)
      end

      it 'redirects to user page' do 
        post users_path, params: valid_params
        expect(response).to redirect_to(user_url(User.last))
      end
    end

    context 'invalid params' do 

      it 'does not add new record to database' do 
        expect{ post users_path, params: invalid_params }.to change(User, :count).by(0)
      end

      it 'redirects to new view' do 
        post users_path, params: invalid_params
        expect(response).to render_template(:new)
      end

      it 'has error in flash' do 
        post users_path, params: invalid_params
        expect(flash[:errors]).to include("Password digest Password can't be blank")
      end
    end

  end

  describe "GET #edit" do 
    subject(:edit_user) { FactoryBot.create(:user) }

    it 'renders the edit template' do 
      get edit_user_path(edit_user)
      expect(response).to render_template(:edit)
    end

    context 'if the user does not exist' do 
      it 'is not a success' do 
        get edit_user_path(-1)
        expect(flash[:errors]).to include("User is not found")
        expect(response).to redirect_to(:root)
      end
    end
  end

  describe 'PATCH #update' do 
    it 'successfully updates record' do 
      patch user_url(user), params: { user: {username: 'patch_test'} }
      expect(response).to redirect_to(user_url(User.find_by(username: 'patch_test')))
    end

    it 'does not update the record' do 
      patch user_url(user), params: { user: {username: ''} }
      expect(flash[:errors]).to include("Username can't be blank")
      expect(response).to render_template(:edit)
    end
  end

  describe "DELETE #destroy" do 
    subject(:delete_user) { FactoryBot.create(:user) }

    it 'deletes the record' do 
      delete user_url(delete_user)
      expect(flash[:notices]).to include("User was successfully deleted")
      expect(response).to redirect_to(users_url)
    end

    it 'does not delete the record' do 
      delete user_url(-1)
      expect(flash[:errors]).to include("User could not be deleted")
      expect(response).to redirect_to(users_url)
    end

   
    it 'add deletes record from database' do 
      delete_user = FactoryBot.create(:user)
      expect{ delete user_url(delete_user) }.to change(User, :count).by(-1)
    end

    it 'removes the user from db' do 
      user_del = FactoryBot.create(:user)
      expect(User.find_by(id: user_del.id)).not_to eq(nil)
      delete user_url(user_del)
      expect(User.find_by(id: user_del.id)).to eq(nil)

    end
  end
  

end
