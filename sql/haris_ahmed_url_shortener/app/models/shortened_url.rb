# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedUrl < ApplicationRecord
    validates :long_url, :short_url, :user_id, presence: true
    validates :long_url, :short_url, uniqueness: true 
    validate :no_spamming

    belongs_to(:submitter, {
        primary_key: :id, #user's id
        foreign_key: :user_id,
        class_name: :User 
    })

    has_many(:visited, {
        primary_key: :id, #shortened_url's id
        foreign_key: :short_url_id,
        class_name: :Visit 
    })

    has_many :visitors, 
        Proc.new { distinct },
        through: :visited,
        source: :visitor 
    
    has_many :taggings,
        primary_key: :id, #shortened_url's id
        foreign_key: :url_id,
        class_name: :Tagging
    
    has_many :tag_topics,
        Proc.new { distinct },
        through: :taggings,
        source: :tag_topic
    
    #creates a random url code that does not exists in the DB
    def self.random_code
        good_url = false

        until good_url
            url = SecureRandom.urlsafe_base64
            unless ShortenedUrl.exists?(short_url: url)
                good_url = true 
            end
        end

        url 
    end

    #User object, long_url -> ShortenedUrl
    #Takes User object and long url and creates new ShortenedUrl object and in DB
    def self.create_short_url(user, long_url)
        url = ShortenedUrl.random_code 
        ShortenedUrl.create!(long_url: long_url, short_url: url, user_id: user.id)
    end

    #Count the number of visits on the shortened url
    def num_clicks
        self.visited.count
    end

    #Count the number of distinct users who have clicked a link
    def num_uniques
        self.visitors.count 
    end

    #Count the number of distinct users who clicked in the last 10 minutes
    def num_recent_uniques
        visited
          .select('user_id')
          .where('created_at > ?', 10.minutes.ago)
          .distinct
          .count
    end

    #Prevents users from submitting more than 5 URLs in a single minute
    def no_spamming
        last_minute = ShortenedUrl
            .where('created_at >= ?', 1.minute.ago)
            .where(user_id: user_id)
            .length 
        errors[:maximum] << 'of five short urls per minute!' if last_minute >= 5
    end
   
    
end
