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
    validate :no_spamming, :nonpremium_max

    belongs_to(:submitter, {
        primary_key: :id, #user's id
        foreign_key: :user_id,
        class_name: :User 
    })

    has_many(:visited, {
        primary_key: :id, #shortened_url's id
        foreign_key: :short_url_id,
        class_name: :Visit,
        dependent: :destroy
    })

    has_many :visitors, 
        Proc.new { distinct },
        through: :visited,
        source: :visitor 
    
    has_many :taggings,
        primary_key: :id, #shortened_url's id
        foreign_key: :url_id,
        class_name: :Tagging,
        dependent: :destroy
    
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

    # run `rails prune:old_urls minutes=n` to see this task in action
    def self.prune(n)
        ShortenedUrl
        .joins(:submitter)
        .joins('LEFT JOIN visits ON visits.short_url_id = shortened_urls.id')
        .where("(shortened_urls.id IN (
            SELECT shortened_urls.id
            FROM shortened_urls
            JOIN visits
            ON visits.short_url_id = shortened_urls.id
            GROUP BY shortened_urls.id
            HAVING MAX(visits.created_at) < \'#{n.minute.ago}\'
        ) OR (
            visits.id IS NULL and shortened_urls.created_at < \'#{n.minutes.ago}\'
        )) AND users.premium = \'f\'")
        .destroy_all

        # The sql for the query would be:
        #
        # SELECT shortened_urls.*
        # FROM shortened_urls
        # JOIN users ON users.id = shortened_urls.submitter_id
        # LEFT JOIN visits ON visits.shortened_url_id = shortened_urls.id
        # WHERE (shortened_urls.id IN (
        #   SELECT shortened_urls.id
        #   FROM shortened_urls
        #   JOIN visits ON visits.shortened_url_id = shortened_urls.id
        #   GROUP BY shortened_urls.id
        #   HAVING MAX(visits.created_at) < "#{n.minute.ago}"
        # ) OR (
        #   visits.id IS NULL and shortened_urls.created_at < '#{n.minutes.ago}'
        # )) AND users.premium = 'f'
    end

    #Prevents users from submitting more than 5 URLs in a single minute
    def no_spamming
        last_minute = ShortenedUrl
            .where('created_at >= ?', 1.minute.ago)
            .where(user_id: user_id)
            .length 
        errors[:maximum] << 'of five short urls per minute!' if last_minute >= 5
    end

    #Prevents non-premium users from submitting more than 5 URLs
    def nonpremium_max
        return if User.find(self.user_id).premium
    
        number_of_urls =
          ShortenedUrl
            .where(user_id: user_id)
            .length
    
        if number_of_urls >= 5
          errors[:Only] << 'premium members can create more than 5 short urls'
        end
    end
   
    
end
