require 'rails_helper'

RSpec.describe "Goals", type: :request do

    let(:user) { FactoryBot.create(:user) }

    before do
        allow_any_instance_of(GoalsController).to receive(:current_user).and_return(user) 
    end

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

    describe "GET #new" do 
        it 'renders new template' do 
            get new_goal_path 
            expect(response).to render_template(:new)
        end
    end

    describe "POST #create" do 
        let(:valid_params) do 
            {
                goal: {
                    title: "Basketball",
                    details: "Play Bball"
                }
            }
        end

        let(:invalid_params) do 
            {
                goal: {
                    title: "Basketball"
                }
            }
        end

        context 'valid params' do 

            it 'add new record to database' do 
                expect{ post goals_url, params: valid_params }.to change(Goal, :count).by(+1)
            end

            it 'redirects to goal page' do 
                post goals_url, params: valid_params
                expect(response).to redirect_to(goal_url(Goal.last))
            end
        end

        context 'invalid params' do 
            it 'does not add new record to database' do 
                expect{ post goals_url, params: invalid_params }.to change(Goal, :count).by(0)
            end
            
            before(:each) { post goals_url, params: invalid_params }
            
            it 'redirects to new view' do 
                expect(response).to render_template(:new)
            end
            it 'has error in flash' do 
                expect(flash[:errors]).to include("Details can't be blank") 
            end
        end

    end

    describe "GET #edit" do 
        let(:goal) {FactoryBot.create(:goal, user_id: user.id)}
        it 'renders the edit template' do 
            get edit_goal_path(goal)
            expect(response).to render_template(:edit)
        end

        context 'if the goal does not exist' do 
            before(:each) { get edit_goal_path(-1) }
            it 'adds error message to flash' do 
                expect(flash[:errors]).to include("Goal is not found")
            end
            it 'redirects to root' do 
                expect(response).to redirect_to(root_url)
            end
        end
    end

    describe 'PATCH #update' do 
        let(:goal) { FactoryBot.create(:goal, user_id: user.id) }

        it 'successfully updates record and redirects to goal page' do 
            patch goal_url(goal), params: { goal: {details: "Patched"} }
            goal_after_patch = Goal.find_by(id: goal.id)
            expect(goal_after_patch.details).to eq("Patched")
            expect(response).to redirect_to(goal_url(goal))
        end

        it 'does not update record with invalid params' do 
            patch goal_url(goal), params: { goal: {details: ""} }
            expect(flash[:errors]).to include("Details can't be blank")
            expect(response).to render_template(:edit) 
        end
    end

    describe 'DELETE #destroy' do 
        let(:goal) { FactoryBot.create(:goal, user_id: user.id) }
        

        it 'deletes the record' do 
            delete goal_url(goal)
            expect(flash[:notices]).to include("Goal was succesfully deleted")
            expect(response).to redirect_to(user_url(user))
        end

        it 'does not delete the record' do 
            delete goal_url(-1)
            expect(flash[:errors]).to include("Goal could not be deleted")
            expect(response).to redirect_to(root_url)
        end
    end

end
