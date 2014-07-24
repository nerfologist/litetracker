class CreateTabs < ActiveRecord::Migration
  def change
    create_table :tabs do |t|
      t.string :name, null: false
      t.integer :project_id, null: false

      t.timestamps
    end
    
    add_index :tabs, :project_id
  end
end
