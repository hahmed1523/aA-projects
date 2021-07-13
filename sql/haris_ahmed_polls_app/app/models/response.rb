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
    # validates :user_id, uniqueness: {
    #     scope: :question_id,
    #     message: 'question has already been answered'
    # }
    validate :not_duplicate_response, unless: -> { answer_choice.nil? }
    validate :respondent_is_not_poll_author, unless: -> { answer_choice.nil? }

    #Associations
    belongs_to :respondent,
        primary_key: :id, #user's id
        foreign_key: :user_id,
        class_name: :User 
    
    belongs_to :answer_choice,
        primary_key: :id, #answer_choices's id
        foreign_key: :answer_choice_id,
        class_name: :AnswerChoice
    
    has_one :question,
        through: :answer_choice,
        source: :question 

    def sibling_responses
        self.question.responses.where.not(id: self.id)
    end

    def respondent_already_answered?
        sibling_responses.exists?(user_id: self.user_id)
    end

    def not_duplicate_response
        if respondent_already_answered?
            errors[:user_id] << "cannot vote twice for question"
        end
    end

    def respondent_is_not_poll_author

        poll_author_id = Poll
          .joins(questions: :answer_choices)
          .where('answer_choices.id = ?', self.answer_choice_id)
          .pluck('polls.user_id')
          .first
    
        if poll_author_id == self.user_id
          errors[:respondent_id] << 'cannot be poll author'
        end
      end
    

end
