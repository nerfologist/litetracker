class ChangeStoryTypeToKind < ActiveRecord::Migration
  def change
    execute "ALTER TABLE stories DROP CONSTRAINT check_valid_type"
    rename_column :stories, :type, :kind
    execute "ALTER TABLE stories ADD CONSTRAINT check_valid_kind CHECK (kind in ('feature', 'bug', 'chore', 'release'))"
  end
end
