class ChangeAdvertisementDescriptionFromStringToText < ActiveRecord::Migration
  def up
    change_column :advertisements, :description, :text
  end

  def down
    change_column :advertisements, :description, :string
  end
end
