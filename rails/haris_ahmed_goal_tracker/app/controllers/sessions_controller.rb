class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def new 
        render :new 
    end

    def create 
        @user = User.find_by_credentials(
            params[:user][:email],
            params[:user][:password]
        )
        if @user.nil? 
            #render json: "Invalid Credentials"
            flash.now[:errors] = ["Invalid credentials."]
            render :new 
        else
            #render json: @user
            login_user!(@user)
            redirect_to user_url(@user)
        end
        #render json: params[:user][:email] 
    end

    def destroy 
        current_user.reset_session_token!
        session[:session_token] = nil 

        redirect_to new_session_url
    end

end