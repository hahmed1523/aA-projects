class GoalsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :require_user!

    def show
        @goal = Goal.find_by(id: params[:id])

        if @goal 
            render :show
        else
            flash.now[:errors] = "Goal is not found"
            redirect_to :root 
        end
    end

    def new 
        @goal = Goal.new 
        render :new 
    end

    def create
        @goal = Goal.new(goal_params)
        @goal.user_id = current_user.id 

        if @goal.save
            redirect_to goal_url(@goal)
        else
            flash.now[:errors] = @goal.errors.full_messages
            render :new
        end
    end

    def edit
        @goal = Goal.find_by(id: params[:id])

        if @goal  
            render :edit
        else
            flash.now[:errors] = "Goal is not found"
            redirect_to :root 
        end

    end


    private

    def goal_params 
        params.require(:goal).permit(:title, :details, :private, :completed)
    end
end