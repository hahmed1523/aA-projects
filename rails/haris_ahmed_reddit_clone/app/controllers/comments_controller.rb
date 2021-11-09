class CommentsController < ApplicationController
    before_action :require_user!, only: [:create, :new]

    def new
        @comment = Comment.new(post_id: params[:post_id])
    end

    def create 
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user_id

        if @comment.save
            redirect_to post_url(@comment.post_id)
        else
            flash[:errors] = @comment.errors.full_messages
            redirect_to new_post_comment_url(@comment.post_id)
        end
    end

    def show
        @comment = Comment.find_by(id: params[:id])
        @new_comment = @comment.child_comments.new 
        
    end

    private
    def comment_params
        params.require(:comment).permit(:post_id, :body, :parent_comment_id)
    end
end