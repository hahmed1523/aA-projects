class AddAdmin2ToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :administrator, :boolean, null: false, default: false 
  end
end
