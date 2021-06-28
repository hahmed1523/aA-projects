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

    has_many :urls,
        # Proc.new { distinct },
        through: :taggings,
        source: :url 
    

    #return the 5 most visited links
    def popular_links
        urls.joins(:visited)
            .group(:short_url, :long_url)
            .order('COUNT(visited.id) DESC')
            .select('long_url, short_url, COUNT(visited.id) as number_of_visits')
            .limit(5)
    end
end
