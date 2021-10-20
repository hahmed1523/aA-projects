require 'rails_helper'

feature "commenting" do 
    given!(:user1) { FactoryBot.create(:user) }
    given!(:user2) { FactoryBot.create(:user) }
    given!(:goal2) { FactoryBot.create(:goal, user_id: user2.id) }

    background(:each) do 
        login_as(user1)
        visit user_url(user2)
    end

    shared_examples "comment" do 
        scenario "should have a form for adding a new comment" do 
            expect(page).to have_content "New Comment"
            expect(page).to have_field "Comment"
        end

        scenario "should save the comment when a user submits one" do 
            fill_in "Comment", with: "my magical comment!"
            click_on "Save Comment"
            expect(page).to have_content "my magical comment!"
        end
    end

    feature "user profile comment" do 
        it_behaves_like "comment"
    end

    feature "goal comment" do 
        background(:each) do 
            click_on goal2.title 
        end

        it_behaves_like "comment"
    end
end