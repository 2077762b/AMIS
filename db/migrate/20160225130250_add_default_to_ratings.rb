class AddDefaultToRatings < ActiveRecord::Migration
  def change
    change_column :trades, :rating, :integer, :default => 0
  end
end
