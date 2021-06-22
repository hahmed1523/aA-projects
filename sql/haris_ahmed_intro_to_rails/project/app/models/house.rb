# == Schema Information
#
# Table name: houses
#
#  id         :bigint           not null, primary key
#  address    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class House < ApplicationRecord
    #must have address
    validates :address, presence: true

    has_many(:residents, {
        primary_key: :id, #house's id
        foreign_key: :house_id,
        class_name: :Person
    })
end
