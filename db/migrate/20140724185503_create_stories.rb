class CreateStories < ActiveRecord::Migration
  def up
    create_table :stories do |t|
      t.references :tab
      t.string :title, null: false
      t.string :type
      t.integer :points
      t.string :state, null: false

      t.timestamps
    end
    
    execute "ALTER TABLE stories ADD CONSTRAINT check_valid_type CHECK (type in ('feature', 'bug', 'chore', 'release'))"
    execute "ALTER TABLE stories ADD CONSTRAINT check_valid_points CHECK (points >= 1 and points <= 4)"
    execute "ALTER TABLE stories ADD CONSTRAINT check_valid_state CHECK (state in ('unstarted', 'started', 'finished', 'rejected', 'accepted'))"
  end
  
  def down
    drop_table :stories
  end
end