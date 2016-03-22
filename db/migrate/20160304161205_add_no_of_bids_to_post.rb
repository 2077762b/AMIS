class AddNoOfBidsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :no_of_bids, :integer, default: 0
  end
end
