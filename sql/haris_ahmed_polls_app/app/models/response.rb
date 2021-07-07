class Response < ApplicationRecord
    validates :user_id, :question_id, :answer_choice_id, presence: true 
    validates :user_id, uniqueness: {
        scope: :question_id,
        message: 'question has already been answered'
    }
end