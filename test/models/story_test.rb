# == Schema Information
#
# Table name: stories
#
#  id         :integer          not null, primary key
#  tab_id     :integer
#  title      :string(255)      not null
#  kind       :string(255)      default("feature")
#  points     :integer
#  state      :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#  ord        :integer          not null
#  maximized  :boolean          default(FALSE), not null
#  deadline   :datetime
#

require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
