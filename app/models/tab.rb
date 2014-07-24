class Tab < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: { scope: :project_id }
  
  belongs_to :project
end
