# == Schema Information
#
# Table name: people
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  house_id   :integer          not null
#  created_at :datetime
#  updated_at :datetime
#
class Person < ApplicationRecord
    #must have name and house id
    validates :name, :house_id, presence: true

    belongs_to(:house, {
        primary_key: :id, #house's id
        foreign_key: :house_id,
        class_name: :House 
    })
end
