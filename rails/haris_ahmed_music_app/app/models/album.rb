# == Schema Information
#
# Table name: albums
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  year       :integer          not null
#  live?      :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  band_id    :integer          not null
#
class Album < ApplicationRecord
    validates :title, :year, :band_id, presence: true
    validates :live?, inclusion: {in: [true, false]}
    validates :title , uniqueness: { scope: :band_id }
    
    after_initialize :set_defaults

    belongs_to :band,
        primary_key: :id, #band's id
        foreign_key: :band_id,
        class_name: :Band 

    def set_defaults
        self.live ||= false  
    end
 end
