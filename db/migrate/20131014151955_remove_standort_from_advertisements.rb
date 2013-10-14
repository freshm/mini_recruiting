class RemoveStandortFromAdvertisements < ActiveRecord::Migration
  def up
    remove_column :advertisements, :standort
  end

  def down
    add_column :advertisements, :standort, :string
  end
end
