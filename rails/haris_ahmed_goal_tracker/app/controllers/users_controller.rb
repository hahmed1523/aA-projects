class UsersController < ApplicationController

    def index
        @users = User.all 
        render :index 
    end

    def show
        @user = User.find_by(id: params[:id])
        render :show
    end
end