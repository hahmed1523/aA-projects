class AddIndexToNotes < ActiveRecord::Migration[5.2]
  def change
    add_index :notes, :track_id 
    add_index :notes, :user_id 
  end
end
