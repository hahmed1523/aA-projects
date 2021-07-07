class AddIndexToAnswerChoices < ActiveRecord::Migration[5.2]
  def change
    add_index :answer_choices, :question_id
  end
end
