class AddBidsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :bids, :integer, default: 0
  end
end
