# == Schema Information
#
# Table name: tracks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  ord        :integer          not null
#  lyrics     :string
#  bonus      :boolean          default(FALSE), not null
#  album_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Track < ApplicationRecord
    validates :title, :ord, :album_id, presence: true
    validates :bonus, inclusion: {in: [true, false]}
    validates :title, uniqueness: { scope: :album_id }

    after_initialize :set_defaults

    belongs_to :album,
        primary_key: :id, #album's id
        foreign_key: :album_id,
        class_name: :Album 
    
    has_one :band,
        through: :album,
        source: :band 


    def set_defaults
        self.bonus ||= false 
    end
end
