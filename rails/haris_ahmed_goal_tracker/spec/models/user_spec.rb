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
    #it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:activation_token) }

    #Validating uniqueness
    subject { FactoryBot.build(:user) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:session_token) }
    it { should validate_uniqueness_of(:activation_token) }
    it { should validate_length_of(:password).is_at_least(6) }

    it 'fails validation with no password expecting a specific message' do 
      no_pass = FactoryBot.build(:user, password_digest: nil)
      no_pass.valid?
      expect(no_pass.errors[:password_digest]).to include('Password can\'t be blank')
    end

  
  end

  describe 'associations' do
  
  end

  describe 'class methods' do 

    describe "password= method" do
      it "should assign an encrypted password to password_digest" do 
        user = FactoryBot.build(:user)
        expect(BCrypt::Password.new(user.password_digest).is_password?('password')).to eq(true)
      end
    end

    describe "is_password? method" do 
      it "should check the password digest with password provided to see if it matches" do 
        user = FactoryBot.build(:user)
        expect(user.is_password?('password')).to eq(true)
      end
    end

    describe "::find_by_credentials" do 
      test_1 = FactoryBot.create(:user)

      it 'returns the correct user' do 
        expect(User.find_by_credentials(test_1.email, test_1.password)).to eq(test_1)
      end
    end

    describe "::generate_security_token" do 
      it 'return a 22 length token' do 
        expect(User.generate_security_token.length).to eq(22)
      end
    end

    describe "ensure_session_token" do
      test1 = User.new
      it 'when a new user is initialized, security token should be assigned' do 
        expect(test1.session_token.nil?).to eq(false)
      end
    end

    describe "reset_session_token!" do 
      test1 = FactoryBot.create(:user)
      old_token = test1.session_token
      it 'change the session token' do 
        expect(test1.reset_session_token!).not_to eq(old_token)
      end
    end
  
  end


end
