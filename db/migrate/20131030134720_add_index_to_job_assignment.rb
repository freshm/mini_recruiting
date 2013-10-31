class AddIndexToJobAssignment < ActiveRecord::Migration
  def change
  	add_index :job_assignments, :moderator_id
  	add_index :job_assignments, :job_application_id
  end
end
