class Project < ActiveRecord::Base
  validates :title, :owner, presence: true
  validates :title, uniqueness: { scope: :owner_id }

  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_many :tabs
  has_many :collaborations, class_name: 'ProjectCollaboration', foreign_key: 'project_id'
  has_many :collaborators, through: :collaborations, source: :user
end