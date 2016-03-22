class RemoveNameFromSubcategory < ActiveRecord::Migration
  def change
    remove_column :subcategories, :name, :string
  end
end
