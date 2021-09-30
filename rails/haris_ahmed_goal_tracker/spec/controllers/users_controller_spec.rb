require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    let(:valid_params) do 
        {
            # id: '1',
            email: 'create_test',
            password: 'password'
        }
    end

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


    # describe 'POST #create' do 
    #     context 'with invalid params' do 
    #         it 'renders the new template' do 
    #             post :create, params: { user: { email: '' } }
    #             expect(response).to render_template(:new)
    #         end
    #     end

    #     context 'with valid params' do

            
            
    #         it 'creates a new user' do 
    #             # post :create, params: { user: valid_params }
    #             # expect(response).to redirect_to(user_url(User.find_by(id: valid_params.id)))
    #             expect{
    #                 post :create, params: {  user: valid_params}
    #             }.to change(User, :count).by(1)
    #         end
    #     end
    # end

end
