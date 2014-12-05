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

class Story < ActiveRecord::Base
  validates :tab, :title, :ord, presence: true
  validates :kind, inclusion: { in: %w(feature bug chore release), allow_nil: true }
  validates :points,
              numericality:
                { only_integer: true,
                  greater_than_or_equal_to: 1,
                  less_than_or_equal_to: 4,
                  allow_nil: true }
  validates :state, inclusion: { in: %w(unstarted started finished accepted rejected) }
  validates :ord, numericality: { greater_than_or_equal_to: 0 }
  validates :maximized, inclusion: { in: [true, false] }
  
  after_initialize :ensure_valid_state
  
  belongs_to :tab
  has_one :project, through: :tab, source: :project
  
  default_scope { order :ord }
  
  after_save do
    project.update_attribute(:updated_at, Time.now)
  end
  
  private
  
  def ensure_valid_state
    self.state ||= 'unstarted'
  end
end
