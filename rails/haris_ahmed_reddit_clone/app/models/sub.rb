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
    
    has_many :post_subs,
        dependent: :destroy,
        primary_key: :id, #Sub id
        foreign_key: :sub_id,
        class_name: :PostSub,
        inverse_of: :sub 

    has_many :posts,
        through: :post_subs,
        source: :post 
    
end
