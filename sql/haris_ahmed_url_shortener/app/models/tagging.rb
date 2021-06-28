# == Schema Information
#
# Table name: taggings
#
#  id         :bigint           not null, primary key
#  tag_id     :integer          not null
#  user_id    :integer          not null
#  url_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tagging < ApplicationRecord 
    validates :tag_id, :user_id, :url_id, presence: true

    belongs_to(:tag_topic,{
        primary_key: :id, #tag_topic id
        foreign_key: :tag_id,
        class_name: :TagTopic
    })

    belongs_to(:url, {
        primary_key: :id, #shortened_url id
        foreign_key: :url_id,
        class_name: :ShortenedUrl
    })

end
