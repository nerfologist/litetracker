class ChangeProjectVelocityToCapacity < ActiveRecord::Migration
  def change
    rename_column :projects, :velocity, :capacity
  end
end