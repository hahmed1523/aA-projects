FactoryBot.define do
  factory :comment do
    body { "MyString" }
    author_id { 1 }
    commentable_id { 1 }
    commentable_type { "MyString" }
  end
end
