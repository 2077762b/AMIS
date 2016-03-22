class AddDeliveryDaysToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :delivery_days, :integer
  end
end
