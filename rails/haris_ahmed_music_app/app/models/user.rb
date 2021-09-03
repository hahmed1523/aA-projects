# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    attr_reader :password 

    validates :email, :session_token, :activation_token_1, presence: true
    validates :password_digest, presence: { message: "Password can't be blank" }
    validates :email, uniqueness: true 
    validates :password, length: { minimum: 6, allow_nil: true }
    after_initialize :ensure_session_token
    after_initialize :set_activation_token

    has_many :notes,
        primary_key: :id, #user's id
        foreign_key: :user_id,
        class_name: :Note 

    #set the password digest from the user provided password
    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    #simplify the password check
    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)
        return nil if user.nil?
        user.is_password?(password) ? user : nil 
    end

    #Create session token if not already exist. Ensure and reset as well.
    def self.generate_session_token
        token = SecureRandom::urlsafe_base64(16)
        while self.exists?(session_token: token)
            token = SecureRandom.urlsafe_base64(16)
        end

        token 
    end

    def reset_session_token!
        self.session_token = self.class.generate_session_token
        self.save!
        self.session_token 
    end

    def generate_unique_activation_token
        token = SecureRandom.urlsafe_base64(16)
        while self.class.exists?(activation_token_1: token)
            token = SecureRandom.urlsafe_base64(16)
        end
        token 
    end

    def activate!
        self.update_attribute(:activated, true)
    end

    private 
    def ensure_session_token 
        self.session_token ||= self.class.generate_session_token
    end

    def set_activation_token
        self.activation_token_1 = generate_unique_activation_token 
    end

end
