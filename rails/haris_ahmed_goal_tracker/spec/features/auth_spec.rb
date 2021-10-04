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

        end

    end

end