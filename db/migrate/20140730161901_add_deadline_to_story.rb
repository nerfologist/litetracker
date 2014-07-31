class AddDeadlineToStory < ActiveRecord::Migration
  def change
    add_column :stories, :deadline, :date
    add_index :stories, :deadline
  end
end
