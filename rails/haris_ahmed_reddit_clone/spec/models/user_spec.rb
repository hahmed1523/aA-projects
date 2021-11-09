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
#
require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'validations' do 
    #Validating presence
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:activation_token) }

    #Boolean validation
    it { is_expected.not_to allow_value(nil).for(:activated) }
    it { is_expected.not_to allow_value(nil).for(:admin) }

    #Validating uniqueness
    subject { FactoryBot.build(:user) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }
    it { should validate_uniqueness_of(:activation_token) }

    #Validating password
    it { should validate_length_of(:password).is_at_least(6) }
    it 'fails validation with no password expecting a specific message' do 
      no_pass = FactoryBot.build(:user, password_digest: nil)
      no_pass.valid? 
      expect(no_pass.errors[:password_digest]).to include('Password can\'t be blank')
    end
  end

  describe 'associations' do 
    it { should have_many(:subs) }
    it { should have_many(:posts) }
    it { should have_many(:comments) }
  end


  describe 'class methods' do 

    let(:user1) { FactoryBot.create(:user) }

    describe 'password= method' do 
      it 'should assign an encrypted password to password_digest' do 
        expect(BCrypt::Password.new(user1.password_digest).is_password?('password')).to eq(true)
      end
    end

    describe 'is_password? method' do 
      it 'should check the password digest with password provided to see if it matches' do 
        expect(user1.is_password?('password')).to eq(true)
      end
    end

    describe '::find_by_credentials' do 
      it 'returns the correct user' do 
        expect(User.find_by_credentials(user1.username, user1.password)).to eq(user1)
      end
    end

    describe '::generate_session_token' do 
      it 'returns a 22 length token' do 
        expect(User.generate_session_token.length).to eq(22)
      end

      let(:token) { User.generate_session_token }

      it 'returns a unique token' do 
        expect(User.exists?(session_token: token)).to eq(false)
      end
    end

    describe 'ensure_session_token' do 
      let(:user){ User.new }
      it 'when a new user is initialized, security token should be assigned' do 
        expect(user.session_token.nil?).to eq(false)
      end
    end

    describe 'reset_session_token!' do 
        test1 = FactoryBot.create(:user)
        old_token = test1.session_token
        it 'changes the session token' do 
          expect(test1.session_token).to eq(old_token)
          expect(test1.reset_session_token!).not_to eq(old_token)
        end

    end

    describe "::generate_activation_token" do 
      it 'returns a 22 length token' do 
        expect(User.generate_activation_token.length).to eq(22)
      end

      let(:token) { User.generate_activation_token }

      it 'returns a unique token' do 
        expect(User.exists?(activation_token: token)).to eq(false)
      end
    end

    describe "set_activation_token" do
      let(:user){ User.new }
      it 'when a new user is initialized, activation token should be assigned' do 
        expect(user.activation_token.nil?).to eq(false)
      end 
    end


    describe "activate!" do 
      let(:user) { FactoryBot.create(:user) }
      it 'changes the activated field from false to true' do 

        expect(user.activated).to eq(false)
        user.activate!
        expect(user.activated).to eq(true)
      end
    end

    describe 'set_defaults' do 
      let(:user) { User.new(admin: nil, activated: nil) }

      it 'sets the value to false if nil' do 
        expect(user.admin.nil?).to eq(false)
        expect(user.activated.nil?).to eq(false)
      end
    end

  end

end
