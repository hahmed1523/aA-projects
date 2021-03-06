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
class User < ApplicationRecord
    include Commentable 
    
    attr_reader :password 

    validates :email,:session_token, 
              :activation_token, presence: true
    validates :email, :session_token, :activation_token, uniqueness: true 
    validates :password_digest, presence: { message: 'Password can\'t be blank' }
    validates :password, length: { minimum: 6, allow_nil: true }
    validates :admin, :activated,  inclusion: { in: [true, false] }
    after_initialize :ensure_session_token
    after_initialize :set_activation_token
    after_initialize :set_defaults
    
    has_many :goals, 
        dependent: :destroy,
        primary_key: :id, #User's id
        foreign_key: :user_id,
        class_name: :Goal 


    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)
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

    def self.generate_unique_activation_token
        token = SecureRandom.urlsafe_base64(16)
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
        self.session_token ||= self.class.generate_session_token
    end

    def set_activation_token
        self.activation_token ||= self.class.generate_unique_activation_token
    end

    def set_defaults
        self.admin ||= false 
        self.activated ||= false 
    end
end
