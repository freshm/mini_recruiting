class CreateJobAssignments < ActiveRecord::Migration
  def change
    create_table :job_assignments do |t|
      t.integer :moderator_id
      t.integer :job_application_id

      t.timestamps
    end
  end
end
