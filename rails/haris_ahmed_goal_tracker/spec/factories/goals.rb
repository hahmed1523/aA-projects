FactoryBot.define do
  factory :goal do
    title { Faker::Hobby.activity }
    details { Faker::Lorem.sentence }
    private { false }
    completed { false }
    user_id { 1 }
  end
end
