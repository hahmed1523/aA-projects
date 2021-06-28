class AddIndexToTagTopics < ActiveRecord::Migration[5.2]
  def change
    add_index :tag_topics, :name, unique: true
  end
end
