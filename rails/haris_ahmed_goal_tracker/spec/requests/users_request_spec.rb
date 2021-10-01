require 'rails_helper'

RSpec.describe "Users", type: :request do

    describe "GET #index" do
        it 'renders the users index' do 
            get users_path 
            expect(response).to be_success
            expect(response).to render_template(:index)
        end
    end

    describe "POST #create" do 
        let(:valid_params) do 
            {
                user: {
                    email: 'post_test',
                    password: 'password'
                }
            }
        end

        it 'add has HTTP status 201 of created' do 
            
            #post users_path, params: {user: { email: 'post_test', password: 'password' }}
            post users_path, params: valid_params
            expect(response.status).to eq(201)           
        end

        it 'add new record to database' do 
            expect{ post users_path, params: valid_params }.to change(User, :count).by(+1)
        end

        
    end

    # # make a get request
    # get users_path

    # # make a post request
    # post users_path, user: {email: 'post_test', password: 'password'}

    # # check the response body and/or status
    # expect(response).to have_http_status(200)
end
