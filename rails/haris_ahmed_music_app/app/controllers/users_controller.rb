class UsersController < ApplicationController
    before_action :require_current_user!, except: [:create, :new, :activate]
    before_action :already_logged_in!

    def create
        @user = User.new(user_params)

        if @user.save
            msg = UserMailer.activation_email(@user)
            msg.deliver_now!
            flash[:notice] = 'Successfully created your account! Check your inbox for an activation email'
            redirect_to new_session_url 
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

    def activate
        @user = User.find_by(activation_token_1: params[:activation_token_1])
        @user.activate!
        login!(@user)
        flash[:notice] = 'Successfully activated your account!'
        redirect_to root_url 
    end


    private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end