FactoryBot.define do
  factory :user_vote do
    user_id { 1 }
    value { 1 }
    votable_id { 1 }
    votable_type { "MyString" }
  end
end
