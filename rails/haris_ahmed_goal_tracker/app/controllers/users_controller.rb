class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        @users = User.all 
        render :index  
    end

    def create
        @user = User.new(user_params)

        if @user.save
            render json: @user, status: :created, location: @user 
        else
            render json: @user.errors.full_messages, status: :unprocessable_entity
        end
    end

    private

    def user_params 
        params.require(:user).permit(:email, :password)
    end
end
