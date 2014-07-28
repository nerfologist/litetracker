class AddOrdToTab < ActiveRecord::Migration
  def change
    add_column :tabs, :ord, :integer, null: false
  end
end
