class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :session_token, null:false 
      t.boolean :activated, null: false, default: false 
      t.string :activation_token, null: false 
      t.boolean :admin, null: false, default: false 

      t.timestamps
    end

    add_index :users, :username 
    add_index :users, :session_token, unique: true 
    add_index :users, :activation_token, unique: true 

  end
end
