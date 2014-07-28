class AddOrdToStory < ActiveRecord::Migration
  def change
    add_column :stories, :ord, :integer, null: false
  end
end
