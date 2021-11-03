# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  username         :string           not null
#  password_digest  :string           not null
#  session_token    :string           not null
#  activated        :boolean          default(FALSE), not null
#  activation_token :string           not null
#  admin            :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null

FactoryBot.define do
  factory :user do
    username { Faker::Internet.user('username') }
    password { "password" }
    session_token { Faker::Alphanumeric.alphanumeric(number: 22) }
    activated { false }
    activation_token { Faker::Alphanumeric.alphanumeric(number: 22) }
    admin { false }
  end
end
