# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  owner_id   :integer          not null
#  velocity   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Project < ActiveRecord::Base
  validates :title, :owner, presence: true
  validates :title, uniqueness: { scope: :owner_id }

  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_many :tabs, dependent: :destroy
  has_many :stories, through: :tabs, source: :stories
  has_many :collaborations, class_name: 'ProjectCollaboration', foreign_key: 'project_id', dependent: :destroy
  has_many :collaborators, through: :collaborations, source: :user
end
