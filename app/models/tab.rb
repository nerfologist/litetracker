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
#  visible    :boolean          default(TRUE), not null
#

class Tab < ActiveRecord::Base
  validates :name, :ord, presence: true
  validates :project, presence: true
  validates :visible, inclusion: { in: [true, false] }
  validates :name, uniqueness: { scope: :project_id }
  validates :ord, numericality: { greater_than_or_equal_to: 0 }
  
  belongs_to :project
  has_many :stories, dependent: :destroy
  
  default_scope { order :ord }
  
  after_save do
    project.update_attribute(:updated_at, Time.now)
  end
end
