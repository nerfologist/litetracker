# == Schema Information
#
# Table name: tabs
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  project_id :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Tab < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: { scope: :project_id }
  
  belongs_to :project
  has_many :stories
end
