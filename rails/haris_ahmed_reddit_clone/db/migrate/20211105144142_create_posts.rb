class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.string :content
      t.integer :sub, null: false 
      t.integer :author, null: false 

      t.timestamps
    end

    add_index :posts, :sub 
    add_index :posts, :author 
  end
end
