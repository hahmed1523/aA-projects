class SessionsController < ApplicationController

    def create
        user = User.find_by_credentials(
            params[:user][:email],
            params[:user][:password]
        )

        if user.nil?
            render json: 'Credentials were wrong'
        else
            render json: "Welcome back #{user.email}"
        end
    end

    def new

        render :new 
    end
end