require 'rails_helper'

RSpec.describe "Session", type: :request do
    describe "GET #new" do 
        it 'renders the new template' do 
            get new_session_path
            expect(response).to render_template(:new)
        end
    end

    describe "POST #create" do 

        user = FactoryBot.create(:user)

        context 'valid params' do 
           
            it 'logs in user' do 
                post session_path, params: {user: {email: user.email, password: user.password}}
                updated_user = User.find(user.id)
                token = updated_user.session_token
                expect(session[:session_token]).to eq(token)
            end

            it 'redirects to root' do 
                post session_path, params: {user: {email: user.email, password: user.password}}
                expect(response.status).to eq(302)
                expect(response).to redirect_to(root_url)
            end
        end

        context 'invalid params' do 

           
            it 'adds error to flash' do 
                post session_path, params: {user: {email: "blah", password: user.password}}
                expect(flash[:errors]).to include("Invalid credentials.")
            end

            it 'renders new template' do 
                post session_path, params: {user: {email: "blah", password: user.password}}
                expect(response).to render_template(:new)
            end
        end
    end

    describe "DELETE #destroy" do 
        user = FactoryBot.create(:user)

        it 'make session[:session_token] nil' do
            #expect(session[:session_token].nil?).to eq(true)
            post session_path, params: {user: {email: user.email, password: user.password}}
            expect(session[:session_token].nil?).to eq(false)
            delete session_url 
            expect(session[:session_token].nil?).to eq(true)
        end

        it 'redirect_to new_session_url' do 
            post session_path, params: {user: {email: user.email, password: user.password}}
            delete session_url
            expect(response).to redirect_to(new_session_url)

        end
    end
end