# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  email            :string           not null
#  password_digest  :string           not null
#  session_token    :string           not null
#  admin            :boolean          default(FALSE), not null
#  activated        :boolean          default(FALSE), not null
#  activation_token :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it "should validate presence of email"
    it "should validate presence of password_digest"
    it "should validate presence of session_token"
    it "should validate presence of admin"
    it "should validate presence of activated"
    it "should validate presence of activation_token"
  
  end

  describe 'associations' do
  
  end

  describe 'class methods' do 
  
  end


end
