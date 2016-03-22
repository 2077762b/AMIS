class RemoveBidsFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :bids, :integer
  end
end
