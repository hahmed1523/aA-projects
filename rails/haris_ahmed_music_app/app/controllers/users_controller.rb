class UsersController < ApplicationController
    before_action :require_current_user!, except: [:create, :new]
    before_action :already_logged_in!

    def create
        @user = User.new(user_params)

        if @user.save
            login!(@user)
            redirect_to bands_url 
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new 
        end
    end

    def new 
        @user = User.new 
        render :new 
    end

    def show
        @user = User.find_by(id: params[:id])
        render :show 
    end


    private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end