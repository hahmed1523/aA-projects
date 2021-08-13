class UsersController < ApplicationController
    before_action :require_current_user!, except: [:create, :new]
    before_action :already_signed_in!
    def create
        @user = User.new(user_params)

        if @user.save
            login!(@user)
            redirect_to cats_url  
        else
            render json: @user.errors.full_messages 
        end
    end

    def new 
        @user = User.new 
    end

    def show 
        @user = User.find_by(id: params[:id])
        render :show
    end

    private 

    def user_params
        params.require(:user).permit(:username, :password)
    end
end