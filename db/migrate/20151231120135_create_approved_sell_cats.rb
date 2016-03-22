class CreateApprovedSellCats < ActiveRecord::Migration
  def change
    create_table :approved_sell_cats do |t|
      t.integer :trader_id
      t.integer :sell_cat_id

      t.timestamps null: false
    end
  end
end
