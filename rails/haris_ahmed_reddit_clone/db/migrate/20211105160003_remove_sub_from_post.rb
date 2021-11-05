class RemoveSubFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :sub, :integer
  end
end
