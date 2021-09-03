class UserMailer < ApplicationMailer
    default from: 'info@musicapp.com'

    def welcome_email(user)
        @user = user 
        @url = 'localhost:3000'
        mail(to: user.email, subject: 'Welcome to Music App')
    end

    def activation_email(user)
        @user = user 
        mail(to: user.email, subject: 'Welcome to Music App! Please activate your account.')
    end
end
