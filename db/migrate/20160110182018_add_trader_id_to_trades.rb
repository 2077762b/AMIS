class AddTraderIdToTrades < ActiveRecord::Migration
  def change
    add_column :trades, :trader_id, :integer
  end
end
