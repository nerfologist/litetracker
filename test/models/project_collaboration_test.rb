# == Schema Information
#
# Table name: project_collaborations
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  project_id :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class ProjectCollaborationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
