# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    attr_reader :password 
    validates :username, :session_token, presence: true
    validates :username, :session_token, uniqueness: true 
    validates :password_digest, presence: {message: "Password can't be blank"}
    validates :password, length: { minimum: 6, allow_nil: true }
    after_initialize :ensure_session_token

    has_many :cats,
        primary_key: :id, #user's id,
        foreign_key: :user_id,
        class_name: :Cat 
    
    has_many :requests,
        primary_key: :id, #user's id,
        foreign_key: :requester_id,
        class_name: :CatRentalRequest


    def password=(password)
        @password = password 
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        return nil if user.nil?
        user.is_password?(password) ? user : nil 
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def reset_session_token!
        self.session_token = self.class.generate_session_token 
        self.save!
        self.session_token 
    end

    def owns_cat?(cat)
        cat.user_id == self.id
    end

    private
    def ensure_session_token
        self.session_token ||= self.class.generate_session_token 
    end
end
