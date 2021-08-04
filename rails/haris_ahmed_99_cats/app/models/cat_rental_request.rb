# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint           not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CatRentalRequest < ApplicationRecord
    STATUS_CHOICES = ['PENDING', 'APPROVED', 'DENIED']
    validates :cat_id, :start_date, :end_date, :status, presence: true
    validates :status, inclusion: {in: STATUS_CHOICES, message: '%{value} is not a valid status'}

    belongs_to :cat,
        primary_key: :id, #cat's id
        foreign_key: :cat_id,
        class_name: :Cat 
end
