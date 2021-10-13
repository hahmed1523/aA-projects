require 'rails_helper'

RSpec.describe "Users", type: :request do

    let(:user) { FactoryBot.create(:user) }

    describe "GET #show" do 
        let(:goal) { FactoryBot.create(:goal, user_id: user.id) }
        it 'renders the show template' do 
            get goal_path(goal)
            expect(response).to render_template(:show)
        end

        context 'if the goal does not exist' do 
            before(:each){
                get goal_path(-1)
            }
            it 'adds error to flash' do
                expect(flash[:errors]).to include("Goal is not found") 
            end


            it 'redirects to root' do 
                expect(response).to redirect_to(root_url)
            end
        end

    end

end
