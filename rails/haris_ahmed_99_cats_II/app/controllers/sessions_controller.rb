class SessionsController < ApplicationController

    def create 
        @user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
        )

        if @user.nil? 
            render json: 'Credentials were wrong'
        else
            login!(@user)
            redirect_to cats_url 
        end

    end

    def new
        render :new 
    end

    def destroy
        logout! 
        redirect_to cats_url 
    end

end