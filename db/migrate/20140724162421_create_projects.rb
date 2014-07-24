class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.integer :owner_id, null: false
      t.integer :velocity

      t.timestamps
    end
    add_index :projects, :owner_id
    add_index :projects, [:owner_id, :title], unique: true
  end
end
