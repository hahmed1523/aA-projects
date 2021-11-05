class UpdateAuthorToAuthorIdInPost < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :author, :author_id
  end
end
