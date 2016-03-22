class RemoveSubscriptionFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :subscription, :boolean
  end
end
