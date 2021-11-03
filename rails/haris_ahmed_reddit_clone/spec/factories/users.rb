FactoryBot.define do
  factory :user do
    username { "MyString" }
    password_digest { "MyString" }
    session_token { "MyString" }
    activated { false }
    activation_token { "MyString" }
    admin { false }
  end
end
