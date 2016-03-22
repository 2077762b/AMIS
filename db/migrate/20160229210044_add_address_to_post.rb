class AddAddressToPost < ActiveRecord::Migration
  def change
    add_column :posts, :line1, :string
    add_column :posts, :city, :string
    add_column :posts, :county, :string
    add_column :posts, :postcode, :string
  end
end
