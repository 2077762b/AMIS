class AddNameToSubcategory < ActiveRecord::Migration
  def change
    add_column :subcategories, :name, :string
    add_index :subcategories, :name, unique: true
  end
end
