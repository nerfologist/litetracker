class SetStoryDeadlineDatetime < ActiveRecord::Migration
  def change
    change_column :stories, :deadline, :datetime
  end
end
