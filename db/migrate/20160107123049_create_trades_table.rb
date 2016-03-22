class CreateTradesTable < ActiveRecord::Migration
  def change
    change_table :trades do |t|
      t.datetime :time
      t.string :delivery_location
      t.integer :post_id
      t.integer :buyer_id
    end
  end
end
