# == Schema Information
#
# Table name: subs
#
#  id          :bigint           not null, primary key
#  title       :string           not null
#  description :string           not null
#  moderator   :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :sub do
    title { [Faker::Company.name, Faker::Company.industry].join(' - ') }
    description { Faker::Lorem.sentence }
    moderator { 1 }
  end
end
