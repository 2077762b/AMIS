class AddAddressToTrades < ActiveRecord::Migration
  def change
    add_column :trades, :line1, :string
    add_column :trades, :city, :string
    add_column :trades, :county, :string
    add_column :trades, :postcode, :string
  end
end
