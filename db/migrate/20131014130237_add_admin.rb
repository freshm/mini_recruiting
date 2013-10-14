class AddAdmin < ActiveRecord::Migration
  def up
    admin = Admin.create!(firstname: "Initial", lastname: "Root", email: "initial@email.com", password: "initpass", password_confirmation: "initpass")
  end

  def down
    admin = Admin.first
    admin.destroy!
  end
end