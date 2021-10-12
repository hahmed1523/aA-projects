require 'spec_helper'
require 'rails_helper'

feature "user features", type: :feature do 

    feature 'the signup process' do 

        scenario 'has a new user page' do 
            visit new_user_url 
            expect(page).to have_content 'New User'
        end

        feature 'signing up a user' do 

            before(:each) do 
                visit new_user_url 
                fill_in 'Email', with: 'new_email_test'
                fill_in 'Password', with: 'password'
                click_on 'Create User'
            end

            scenario 'shows username on the homepage after signup' do
                expect(page).to have_content 'new_email_test'
            end

            scenario 'shows Sign Out button on the homepage after signup' do
                expect(page).to have_selector(:link_or_button, 'Sign Out')
            end

        end
        let(:user) { FactoryBot.create(:user) }
        let(:log_on){
            
            visit new_session_url
            fill_in 'Email', with: user.email 
            fill_in 'Password', with: user.password 
            click_on 'Sign In'
        }
        feature 'logging in' do 
            scenario 'shows username on the homepage after login' do 
                log_on 
                expect(page).to have_content user.email 

            end
        end

        feature 'logging out' do 
            scenario 'begins with a logged out state' do 
                visit root_url 
                expect(page).not_to have_content user.email 
                expect(page).not_to have_selector(:link_or_button, 'Sign Out')
            end

            scenario 'doesn\'nt show username on the homepage after logout' do 
                log_on 
                expect(page).to have_content user.email 
                click_on 'Sign Out'
                expect(page).not_to have_content user.email 
            end

            
        end

    end

end