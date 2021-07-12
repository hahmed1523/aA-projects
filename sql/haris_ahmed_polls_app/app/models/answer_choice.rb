# == Schema Information
#
# Table name: answer_choices
#
#  id          :bigint           not null, primary key
#  question_id :integer          not null
#  text        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class AnswerChoice < ApplicationRecord
    validates :question_id, :text, presence: true

    #Associations
    belongs_to :question,
        primary_key: :id, #question's id
        foreign_key: :question_id,
        class_name: :Question 
    
    
end
