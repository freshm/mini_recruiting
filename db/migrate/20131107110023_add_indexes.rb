class AddIndexes < ActiveRecord::Migration
  def change
  	add_index(:vacancies, :admin_id)
  	add_index(:job_applications, :user_id)
  	add_index(:job_applications, :vacancy_id)
  end
end
