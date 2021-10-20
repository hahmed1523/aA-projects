module AuthFeaturesHelper 
    def login_as(user)
        visit new_session_url
        fill_in "Email", with: user.email 
        fill_in "Password", with: "password"
        click_button "Sign In"
    end
end