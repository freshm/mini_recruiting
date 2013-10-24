class RenameAdvertisementsToVacancies < ActiveRecord::Migration
  def change
        rename_table :advertisements, :vacancies
   end 
end
