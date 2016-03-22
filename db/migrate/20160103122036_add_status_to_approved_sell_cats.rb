class AddStatusToApprovedSellCats < ActiveRecord::Migration
  def change
    add_column :approved_sell_cats, :status, :integer
  end
end
