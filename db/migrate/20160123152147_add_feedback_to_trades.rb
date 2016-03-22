class AddFeedbackToTrades < ActiveRecord::Migration
  def change
    add_column :trades, :feedback, :text
  end
end
