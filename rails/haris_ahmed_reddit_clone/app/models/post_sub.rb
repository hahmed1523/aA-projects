class PostSub < ApplicationRecord
    validates :post_id, :sub_id, presence: true
    validates :post_id, uniqueness: { scope: :sub_id }

    belongs_to :post,
        primary_key: :id, #Post id
        foreign_key: :post_id, 
        class_name: :Post,
        inverse_of: :post_subs
    
    belongs_to :sub,
        primary_key: :id, #Sub id
        foreign_key: :sub_id, 
        class_name: :Sub,
        inverse_of: :post_subs
end
