# == Schema Information
#
# Table name: tabs
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  project_id :integer          not null
#  created_at :datetime
#  updated_at :datetime
#  ord        :integer          not null
#

require 'test_helper'

class TabTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
