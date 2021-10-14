require 'spec_helper'
require 'rails_helper'

feature "goal features", type: :feature do

    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }

    

    feature 'show message that user has no goals or list their goals if they have some' do 
        let(:sign_on_u1) {
            visit new_session_url 
            fill_in 'Email', with: user1.email
            fill_in 'Password', with: user1.password 
            click_on 'Sign In' 
        }

        let(:sign_on_u2) {
            visit new_session_url 
            fill_in 'Email', with: user2.email
            fill_in 'Password', with: user2.password 
            click_on 'Sign In' 
        }

        scenario 'be on user\'s page' do 
            sign_on_u1
            expect(page).to have_content("#{user1.email}'s Page")
        end

        scenario 'say user has no goals' do
            sign_on_u1
            expect(page).to have_content("You have no goals.")
        end

        scenario 'list goal title and does not say you have no goals' do 
            goal = FactoryBot.create(:goal, user_id: user2.id)
            sign_on_u2
            expect(page).not_to have_content("You have no goals")
            expect(page).to have_content(goal.title)
        end
    end
    
end