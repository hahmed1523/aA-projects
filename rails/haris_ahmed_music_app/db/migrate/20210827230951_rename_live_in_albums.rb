class RenameLiveInAlbums < ActiveRecord::Migration[5.2]
  def change
    rename_column :albums, :live?, :live 
  end
end
