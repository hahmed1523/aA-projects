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
    validate :does_not_overlap_approved_request

    belongs_to :cat,
        primary_key: :id, #cat's id
        foreign_key: :cat_id,
        class_name: :Cat 

    def overlapping_requests 

        CatRentalRequest
            .where.not(id: self.id)
            .where(cat_id: self.cat_id)
            .where.not('start_date > :end_date OR end_date < :start_date', 
                start_date: self.start_date, end_date: self.end_date)
    end

    def overlapping_approved_requests
        overlapping_requests.where(status: 'APPROVED')
    end

    def overlapping_pending_requests
        overlapping_requests.where(status: 'PENDING')
    end

    def approve!
        raise 'not pending' unless self.status == 'PENDING'

        transaction do 
            self.status = 'APPROVED'
            self.save!

            overlapping_pending_requests.each do |req|
                req.update!(status: 'DENIED')
            end
        end
    end

    def denied?
        self.status == 'DENIED'
    end

    def deny!
        self.status = 'DENIED'
        self.save!
    end

    def pending?
        self.status == 'PENDING'
    end

    def does_not_overlap_approved_request

        return if self.denied?
        
        unless overlapping_approved_requests.empty?
            errors[:base] << 'Request conflicts with exising approved request'
        end
    end
end
