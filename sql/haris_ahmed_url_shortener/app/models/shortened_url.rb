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

    has_many(:visitors, {
        through: :visited,
        source: :visitor 
    })

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


    
    
end
