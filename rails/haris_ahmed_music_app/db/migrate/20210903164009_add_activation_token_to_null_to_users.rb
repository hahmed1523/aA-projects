class AddActivationTokenToNullToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :activation_token_1, :string, null: false, default: ""
  end
end
