class CreateBid < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.float :amount
      t.integer :post_id
    end
  end
end
