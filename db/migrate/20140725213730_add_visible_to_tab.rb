class AddVisibleToTab < ActiveRecord::Migration
  def change
    add_column :tabs, :visible, :boolean, default: true, null: false
  end
end