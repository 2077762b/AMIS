class AddHiddenToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :hidden, :integer
  end
end
