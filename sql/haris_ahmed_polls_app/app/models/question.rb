# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  poll_id    :integer          not null
#  text       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Question < ApplicationRecord
    validates :poll_id, :text, presence: true 

    #Associations
    belongs_to :poll,
        primary_key: :id, #poll's id
        foreign_key: :poll_id,
        class_name: :Poll
    
    has_many :answer_choices,
        primary_key: :id, #question's id
        foreign_key: :question_id,
        class_name: :AnswerChoice
    
    has_many :responses,
        through: :answer_choices,
        source: :responses
    
    def results_n
        answer_choices = self.answer_choices
        results = Hash.new(0)

        answer_choices.each do |choice|
            results[choice.text] = choice.responses.count
        end

        results 
    end

    def results_better
        answer_choices = self.answer_choices.includes(:responses)
        results = Hash.new(0)

        answer_choices.each do |choice|
            results[choice.text] = choice.responses.length
        end

        results
    end

    def results
        answer_choices_with_counts = self
            .answer_choices
            .select("answer_choices.*, COUNT(responses.id) AS responses_count")
            .left_outer_joins(:responses)
            .group('answer_choices.id')
        
        results = {}

        answer_choices_with_counts.each do |choice|
            results[choice.text] = choice.responses_count
        end

        results 
    end
end
