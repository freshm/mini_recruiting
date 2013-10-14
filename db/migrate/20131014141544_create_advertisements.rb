class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :title
      t.string :location
      t.string :description
      t.string :standort
      t.string :requirement

      t.timestamps
    end
  end
end
