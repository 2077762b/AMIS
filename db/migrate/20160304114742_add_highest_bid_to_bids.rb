class AddHighestBidToBids < ActiveRecord::Migration
  def change
    add_column :bids, :highest_bid, :boolean, default: false
    add_column :bids, :trader_id, :integer
  end
end
