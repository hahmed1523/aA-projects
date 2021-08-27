class ChangeLiveInAlbums < ActiveRecord::Migration[5.2]
  def change
    change_column :albums, :live?, :boolean, default: true
  end
end
