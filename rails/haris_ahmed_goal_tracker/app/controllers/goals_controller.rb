class GoalsController < ApplicationController
    skip_before_action :verify_authenticity_token

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


    private

    def goal_params 
        params.require(:goal).permit(:title, :details, :private, :completed)
    end
end