FactoryBot.define do
  factory :goal do
    title { "MyString" }
    details { "MyString" }
    private { false }
    completed { false }
    user_id { "" }
  end
end
