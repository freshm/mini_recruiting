class AddDutiesToVacancies < ActiveRecord::Migration
  def change
    add_column :vacancies, :duties, :string
  end
end
