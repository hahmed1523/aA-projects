# == Schema Information
#
# Table name: goals
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  details    :string           not null
#  private    :boolean          default(FALSE), not null
#  completed  :boolean          default(FALSE), not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Goal < ApplicationRecord
    validates :title, :details, :user_id, presence: true 
    validates :private, :completed, inclusion: { in: [true, false] }
    after_initialize :set_defaults



    private 
    def set_defaults
        self.private ||= false 
        self.completed ||= false 
    end
end
