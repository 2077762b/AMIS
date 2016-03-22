class AddActionFieldsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :highest_bidder, :integer, default: 0
    add_column :posts, :auction, :boolean
    add_column :posts, :expired, :boolean, default: false
  end
end
