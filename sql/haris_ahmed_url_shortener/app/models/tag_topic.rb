# == Schema Information
#
# Table name: tag_topics
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TagTopic < ApplicationRecord
    validates :name, presence: true, uniqueness: true 

    has_many(:taggings, {
        primary_key: :id, #tag_topic id
        foreign_key: :tag_id,
        class_name: :Tagging
    })

end
