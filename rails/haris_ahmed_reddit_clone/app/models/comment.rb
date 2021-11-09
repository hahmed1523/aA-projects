class Comment < ApplicationRecord
    validates :author, :post, :body, presence: true 

    belongs_to :author,
        primary_key: :id, #User's id
        foreign_key: :user_id,
        class_name: :User,
        inverse_of: :comments 

    belongs_to :post, inverse_of: :comments 
end
