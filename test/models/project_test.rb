# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  owner_id   :integer          not null
#  velocity   :integer          default(5)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
