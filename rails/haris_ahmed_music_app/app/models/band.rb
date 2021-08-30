# == Schema Information
#
# Table name: bands
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Band < ApplicationRecord
    validates :name, presence: true 

    has_many :albums,
        dependent: :destroy,
        primary_key: :id, #band's id
        foreign_key: :band_id,
        class_name: :Album 
    
    has_many :tracks,
        through: :albums,
        source: :tracks
end
