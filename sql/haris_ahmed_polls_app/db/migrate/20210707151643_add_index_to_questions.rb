class AddIndexToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_index :questions, :poll_id 
  end
end
