class ChangeAdvertisementsIdToVanciesId < ActiveRecord::Migration
  def change
  	rename_column :job_applications, :advertisement_id, :vacancy_id
  end
end
