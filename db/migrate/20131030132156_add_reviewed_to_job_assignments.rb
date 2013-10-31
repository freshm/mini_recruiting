class AddReviewedToJobAssignments < ActiveRecord::Migration
  def change
    add_column :job_assignments, :reviewed, :boolean, default: false
  end
end
