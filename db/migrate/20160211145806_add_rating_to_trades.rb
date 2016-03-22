class AddRatingToTrades < ActiveRecord::Migration
  def change
    add_column :trades, :rating, :integer
  end
end
