class CreateApprovedBuyCats < ActiveRecord::Migration
  def change
    create_table :approved_buy_cats do |t|
      t.integer :trader_id
      t.integer :buy_cat_id

      t.timestamps null: false
    end
  end
end
