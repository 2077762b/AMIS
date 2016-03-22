class AddStatusToApprovedBuyCats < ActiveRecord::Migration
  def change
    add_column :approved_buy_cats, :status, :integer
  end
end
