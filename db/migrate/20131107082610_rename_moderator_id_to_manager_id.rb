class RenameModeratorIdToManagerId < ActiveRecord::Migration
  def change
  	rename_column :job_assignments, :moderator_id, :manager_id
  end
end
