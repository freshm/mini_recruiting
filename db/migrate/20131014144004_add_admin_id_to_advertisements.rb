class AddAdminIdToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :admin_id, :integer
  end
end
