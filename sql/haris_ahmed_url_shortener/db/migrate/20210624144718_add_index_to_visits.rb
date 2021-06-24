class AddIndexToVisits < ActiveRecord::Migration[5.2]
  def change
    add_index :visits, :user_id
    add_index :visits, :short_url_id
  end
end
