class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :job_applications, :wage, :salary
  end
end
