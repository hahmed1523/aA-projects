# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  email            :string           not null
#  password_digest  :string           not null
#  session_token    :string           not null
#  admin            :boolean          default(FALSE), not null
#  activated        :boolean          default(FALSE), not null
#  activation_token :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    session_token { Faker::Alphanumeric.alphanumeric(number: 16) }
    activation_token { Faker::Alphanumeric.alphanumeric(number: 16) }
  end
end
