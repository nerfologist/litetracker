class CreateProjectCollaborations < ActiveRecord::Migration
  def change
    create_table :project_collaborations do |t|
      t.references :user, null: false, index: true
      t.references :project, null: false, index: true

      t.timestamps
    end
    
    add_index :project_collaborations, [:user_id, :project_id], unique: true
  end
end
