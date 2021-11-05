class SubsController < ApplicationController
    before_action :require_user!, except: [:index, :show]
    before_action :require_user_owns_sub!, only: [:edit, :update]

    def index 
        @subs = Sub.all 
        render :index 
    end

    def show 
        @sub = Sub.find_by(id: params[:id])

        if @sub  
            render :show 
        else
            flash.now[:errors] = "Sub is not found"
            redirect_to :root 
        end
    end

    def new 
        @sub = User.new 
        render :new 
    end

    def create 
        @sub = Sub.new(sub_params)
        @sub.moderator_id = current_user.id 

        if @sub.save
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :new 
        end
    end

    def edit 
        @sub = Sub.find_by(id: params[:id])
        render :edit
    end

    def update 
        @sub = Sub.find_by(id: params[:id])

        if @sub.update(sub_params)
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :edit 
        end
    end

    private
    def sub_params
        params.require(:sub).permit(:title, :description)
    end

    def require_user_owns_sub!
        return if current_user.subs.find_by(id: params[:id])
        flash.now[:errors] = "Forbidden: You are not the Moderator of Sub"
        redirect_to :root 
    end
end