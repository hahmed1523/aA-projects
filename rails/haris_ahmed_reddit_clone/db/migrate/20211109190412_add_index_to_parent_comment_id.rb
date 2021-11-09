class AddIndexToParentCommentId < ActiveRecord::Migration[5.2]
  def change
    add_index :comments, :parent_comment_id
  end
end
