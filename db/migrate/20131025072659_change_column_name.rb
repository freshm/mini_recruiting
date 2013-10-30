class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :job_applications, :applicant_id, :user_id
  end
end
