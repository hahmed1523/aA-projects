class CommentsController < ApplicationController

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

    private
    def comment_params
        params.require(:comment).permit(:user_id, :post_id, :body)
    end
end