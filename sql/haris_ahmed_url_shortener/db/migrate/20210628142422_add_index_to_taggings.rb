class AddIndexToTaggings < ActiveRecord::Migration[5.2]
  def change
    add_index :taggings, :tag_id 
    add_index :taggings, :user_id 
    add_index :taggings, :url_id 
  end
end
