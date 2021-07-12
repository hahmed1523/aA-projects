# == Schema Information
#
# Table name: polls
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Poll < ApplicationRecord
    validates :user_id, :title, presence: true 

    #Associations
    belongs_to :author,
        primary_key: :id, #user's id
        foreign_key: :user_id,
        class_name: :User
    
    has_many :questions,
        primary_key: :id, #poll's id
        foreign_key: :poll_id,
        class_name: :Question 
end
