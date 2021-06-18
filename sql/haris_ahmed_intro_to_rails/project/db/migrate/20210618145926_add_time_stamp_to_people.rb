class AddTimeStampToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :created_at, :datetime
    add_column :people, :updated_at, :datetime
  end
end
