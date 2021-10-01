require 'rails_helper'

RSpec.describe "Users", type: :request do

    describe "GET #index" do
        it 'renders the users index' do 
            get users_path 
            expect(response).to be_success
            expect(response).to render_template(:index)
        end
    end

    describe "GET #show" do 
        it 'renders the show template' do 
            user = FactoryBot.create(:user)
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
                    email: 'post_test',
                    password: 'password'
                }
            }
        end

        let(:invalid_params) do 
            {
                user: {
                    password: 'password'
                }
            }
        end

        context 'valid params' do 

            it 'add new record to database' do 
                expect{ post users_path, params: valid_params }.to change(User, :count).by(+1)
            end

            it 'has HTTP status 302 of redirect' do 
                
                post users_path, params: valid_params
                expect(response.status).to eq(302)           
            end

            it 'redirects to user page' do 
                post users_path, params: valid_params
                expect(response).to redirect_to(user_url(User.last))
            end

        end

        context 'invalid params' do 
            # it 'has HTTP status 422 of unprocessable entity' do 
            #     post users_path, params: invalid_params
            #     expect(response.status).to eq(422) 
            # end

            it 'does not add new record to database' do 
                expect{ post users_path, params: invalid_params }.to change(User, :count).by(0)
            end

            
            it 'redirects to new view' do
                post users_path, params: invalid_params
                expect(response).to render_template(:new)
            end

            it 'has error in flash' do 
                post users_path, params: invalid_params
                expect(flash[:errors]).to eq(['Email can\'t be blank'])
            end
        
        end

        
    end

end
