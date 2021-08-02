# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  birth_date  :date             not null
#  color       :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Cat < ApplicationRecord
    COLORS = ['black', 'white', 'brown', 'gray']
    SEX = ['M', 'F']
    validates :name, :birth_date, :color, :sex, :description, presence: true 
    validates :color, inclusion: {in: COLORS, message: '%{value} is not a valid color'} 
    validates :sex, inclusion: {in: SEX, message: '%{value} is not a valid sex'}

    def age
        ((Time.zone.now - self.birth_date.to_time)/ 1.year.seconds).floor
    end
end
