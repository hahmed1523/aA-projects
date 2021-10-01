class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        @users = User.all 
        render :index  
    end

    def show
        @user = User.find_by(id: params[:id])

        if @user 
            render :show
        else
            flash.now[:errors] = "User is not found"
            redirect_to :root 
        end
    end

    def new 
        @user = User.new 
        render :new 
    end

    def create
        @user = User.new(user_params)

        if @user.save
            #render json: @user, status: :created, location: @user 
            redirect_to user_url(@user)
        else
            #render json: @user.errors.full_messages, status: :unprocessable_entity
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def edit
        @user = User.find_by(id: params[:id])

        if @user 
            render :edit
        else
            flash.now[:errors] = "User is not found"
            redirect_to :root 
        end

    end

    def update 
        @user = User.find_by(id: params[:id])

        if @user.update(user_params)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :edit 
        end
    end

    def destroy
        @user = User.find_by(id: params[:id])
        if @user
            @user.destroy
            flash.now[:notices] = "User was succesfully deleted" 
            redirect_to users_url
        else
            flash.now[:errors] = "User could not be deleted" 
            redirect_to users_url 
        end
    end

    private

    def user_params 
        params.require(:user).permit(:email, :password)
    end
end
