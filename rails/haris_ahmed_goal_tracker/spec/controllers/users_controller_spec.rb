require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    describe 'GET #index' do 
        it 'renders the user\'s index' do 
            get :index 
            expect(response).to be_success
            expect(response).to render_template(:index)
        end
    end


    describe 'GET #show' do 
        it 'renders the show template' do
            user = User.create!(email: 'show_test', password_digest: 'qwertyuioplkjhgfdsaqwe', activation_token: 'asdfghjklasdfghjklasdf')
            get :show, params: { id: user.id }
            expect(response).to render_template(:show) 
        end
    end


    describe 'POST #create' do 
        context 'with invalid params' do 
            it 'renders the new template'
        end

        context 'with valid params' do 
            it 'redirects to user page'
        end
    end

end
