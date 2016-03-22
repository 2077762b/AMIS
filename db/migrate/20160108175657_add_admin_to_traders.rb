class AddAdminToTraders < ActiveRecord::Migration
  def change
    add_column :traders, :admin, :boolean
  end
end
