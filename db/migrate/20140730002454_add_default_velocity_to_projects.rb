class AddDefaultVelocityToProjects < ActiveRecord::Migration
  def change
    change_column :projects, :velocity, :integer, default: 5
  end
end
