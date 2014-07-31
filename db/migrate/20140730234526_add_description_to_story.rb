class AddDescriptionToStory < ActiveRecord::Migration
  def change
    add_column :stories, :description, :text
  end
end
