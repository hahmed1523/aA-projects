# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  track_id   :integer          not null
#  user_id    :integer          not null
#  message    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Note < ApplicationRecord
    validates :track_id, :user_id, :message, presence: true 

    belongs_to :track, 
        primary_key: :id, #track's id
        foreign_key: :track_id,
        class_name: :Track 
    
    belongs_to :user,
        primary_key: :id, #user's id
        foreign_key: :user_id,
        class_name: :User 

end
