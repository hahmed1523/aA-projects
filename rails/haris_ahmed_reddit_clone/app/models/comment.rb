class Comment < ApplicationRecord
    validates :author, :post, :body, presence: true 

    belongs_to :author,
        primary_key: :id, #User's id
        foreign_key: :user_id,
        class_name: :User,
        inverse_of: :comments 

    belongs_to :post, inverse_of: :comments 

    has_many :child_comments,
        primary_key: :id, #Comment id
        foreign_key: :parent_comment_id,
        class_name: :Comment 
    
    belongs_to :parent_comment,
        primary_key: :id, #Comment id
        foreign_key: :parent_comment_id,
        class_name: :Comment,
        optional: true 
end
