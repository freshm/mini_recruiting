class CreateJobApplications < ActiveRecord::Migration
  def change
    create_table :job_applications do |t|
      t.float :wage
      t.text :note
      t.integer :applicant_id
      t.integer :advertisement_id

      t.timestamps
    end
  end
end
