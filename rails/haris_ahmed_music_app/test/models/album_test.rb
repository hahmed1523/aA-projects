# == Schema Information
#
# Table name: albums
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  year       :integer          not null
#  live       :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  band_id    :integer          not null
#
require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
