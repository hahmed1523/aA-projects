require 'rails_helper'

RSpec.describe "Session", type: :request do

  let(:user) { FactoryBot.create(:user) }

  describe "GET #new" do 
    it 'renders the new template' do 
      get new_session_path 
      expect(response).to render_template(:new)
    end
  end


  describe "POST #create" do 

    context 'valid params' do 
      subject(:log_user) { FactoryBot.create(:user) }

      it 'logs in user' do 
        post session_path, params: { user: { username: log_user.username, password: log_user.password } }
        updated_user = User.find(log_user.id)
        token = updated_user.session_token
        expect(session[:session_token]).to eq(token)
      end

      it 'redirects to root' do 
        post session_path, params: { user: { username: user.username, password: 'password' } }
        expect(response).to redirect_to(:root)
      end
    end

    context 'invalid params' do 
        let(:invalid_params) do 
            {
              user: {
                username: 'blah',
                password: 'password'
              }
            }
        end

        it 'adds error to flash' do 
            post session_path, params: invalid_params
            expect(flash[:errors]).to include("Invalid credentials.")
        end

        it 'renders new template' do 
            post session_path, params: invalid_params
            expect(response).to render_template(:new)
        end
    end
  end

  describe "DELETE #destroy" do 
    subject(:del_session) { FactoryBot.create(:user) }

    it 'make session[:session_token] nil' do 
        post session_path, params: {user: {username: del_session.username, password: del_session.password}}
        expect(session[:session_token].nil?).to eq(false)
        delete session_url 
        expect(session[:session_token].nil?).to eq(true)

    end

    it 'redirect_to new_session_url' do 
        post session_path, params: {user: {username: del_session.username, password: del_session.password}}
        delete session_url
        expect(response).to redirect_to(new_session_url)
    end
  end
end
