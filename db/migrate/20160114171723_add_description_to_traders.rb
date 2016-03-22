class AddDescriptionToTraders < ActiveRecord::Migration
  def change
    add_column :traders, :description, :text
  end
end
