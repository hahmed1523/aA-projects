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
class User < ApplicationRecord
    attr_reader :password 

    validates :username, :session_token, :activation_token, presence: true 
    validates :activated, :admin, inclusion: { in: [true, false] }
    validates :username, :activation_token, :session_token, uniqueness: true 
    validates :password, length: { minimum: 6, allow_nil: true }
    validates :password_digest, presence: { message: 'Password can\'t be blank' }
    after_initialize :ensure_session_token
    after_initialize :set_activation_token
    after_initialize :set_defaults

    has_many :subs, 
        primary_key: :id, #User's id
        foreign_key: :moderator_id,
        class_name: :Sub,
        inverse_of: :moderator  
    
    has_many :posts,
        primary_key: :id, #User's id
        foreign_key: :author,
        class_name: :Post,
        inverse_of: :author 

    has_many :comments, inverse_of: :author 

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

    def self.generate_activation_token
        token = SecureRandom::urlsafe_base64(16)
        while self.exists?(activation_token: token)
            token = SecureRandom.urlsafe_base64(16)
        end
        token 
    end

    def activate! 
        self.update_attribute(:activated, true)
    end


    private 

    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end

    def set_activation_token
        self.activation_token ||= User.generate_activation_token
    end

    def set_defaults
        self.admin ||= false 
        self.activated ||= false 
    end
end
