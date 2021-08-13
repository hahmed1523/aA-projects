class SessionsController < ApplicationController

    before_action :already_signed_in!, only: [:create, :new]
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