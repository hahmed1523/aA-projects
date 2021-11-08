# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :string
#  sub        :integer          not null
#  author     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord
    validates :title, :author, presence: true 
    #validates :title, uniqueness: { scope: [:author, :sub]}

    belongs_to :author, 
        primary_key: :id, #User's id
        foreign_key: :author_id,
        class_name: :User,
        inverse_of: :posts 
    
        has_many :post_subs,
        dependent: :destroy,
        primary_key: :id, #Post id
        foreign_key: :post_id,
        class_name: :PostSub,
        inverse_of: :post 

end
