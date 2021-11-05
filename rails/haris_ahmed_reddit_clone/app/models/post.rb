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
    validates :title, :sub, :author, presence: true 
    validates :title, uniqueness: { scope: [:author, :sub]}

    belongs_to :author_a, 
        primary_key: :id, #User's id
        foreign_key: :author,
        class_name: :User 
    
    belongs_to :sub_a,
        primary_key: :id, #Sub's id
        foreign_key: :sub,
        class_name: :Sub 

end
