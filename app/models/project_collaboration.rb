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

class ProjectCollaboration < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
end
