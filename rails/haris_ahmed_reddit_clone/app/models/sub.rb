# == Schema Information
#
# Table name: subs
#
#  id          :bigint           not null, primary key
#  title       :string           not null
#  description :string           not null
#  moderator   :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Sub < ApplicationRecord
    validates :title, :description, :moderator, presence: true 
    validates :title, uniqueness: true 

    belongs_to :moderator,
        primary_key: :id, #User's id
        foreign_key: :moderator_id,
        class_name: :User,
        inverse_of: :subs 
    
    # has_many :posts,
    #     dependent: :destroy,
    #     primary_key: :id, #Sub's id
    #     foreign_key: :author,
    #     class_name: :Post 
end
