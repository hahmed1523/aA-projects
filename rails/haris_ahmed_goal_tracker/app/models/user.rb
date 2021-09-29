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
    attr_reader :password 

    validates :email,:session_token, 
              :activation_token, presence: true
    validates :email, :session_token, :activation_token, uniqueness: true 
    validates :password_digest, presence: { message: 'Password can\'t be blank' }
    validates :password, length: { minimum: 6, allow_nil: true }


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
end
