class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.integer :track_id, null: false 
      t.integer :user_id, null: false 
      t.text :message, null: false 

      t.timestamps
    end
  end
end
