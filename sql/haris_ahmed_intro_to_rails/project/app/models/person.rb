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
end
