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

    validates :email, :session_token, presence: true
    validates :password_digest, presence { message: "Password can't be blank" }
    validates :email, uniqueness: true 
    validates :password, length: { minimum: 6, allow_nil: true }


    #set the password digest from the user provided password
    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    #simplify the password check
    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end
end
