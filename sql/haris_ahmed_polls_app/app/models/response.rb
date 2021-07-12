# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  user_id          :integer          not null
#  question_id      :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Response < ApplicationRecord
    validates :user_id, :question_id, :answer_choice_id, presence: true 
    validates :user_id, uniqueness: {
        scope: :question_id,
        message: 'question has already been answered'
    }

    #Associations
    belongs_to :respondent,
        primary_key: :id, #user's id
        foreign_key: :user_id,
        class_name: :User 

end
