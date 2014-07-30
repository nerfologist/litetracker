class AddMaximizedToStory < ActiveRecord::Migration
  def change
    add_column :stories, :maximized, :boolean, null: false, default: false
    change_column :stories, :kind, :string, default: 'feature'
  end
end
