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
require 'rails_helper'
require 'bcrypt'

RSpec.describe User, type: :model do

  describe 'validations' do

    #Validating presence
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:admin) }
    it { should validate_presence_of(:activated) }
    it { should validate_presence_of(:activation_token) }

    #Validating uniqueness
    subject { User.new(email: 'test', password_digest: 'password', session_token: 's_token', 
              admin: false, activated: false, activation_token: 'a_token' ) } 
    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:session_token) }
    it { should validate_uniqueness_of(:activation_token) }

  
  end

  describe 'associations' do
  
  end

  describe 'class methods' do 

    describe "password= method" do
      it "should assign an encrypted password to password_digest" do 
        user = User.new(email: 'test', password: 'password', session_token: 's_token', 
          admin: false, activated: false, activation_token: 'a_token')
        expect(BCrypt::Password.new(user.password_digest).is_password?('password')).to eq(true)
      end
    end

    describe "is_password? method" do 
      it "should check the password digest with password provided to see if it matches" do 
        user = User.new(email: 'test', password: 'password', session_token: 's_token', 
          admin: false, activated: false, activation_token: 'a_token')
        expect(user.is_password?('password')).to eq(true)
      end
    end
  
  end


end
