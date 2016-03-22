class AddPictureToTraders < ActiveRecord::Migration
  def change
    add_reference :traders, :picture, index: true, foreign_key: true
  end
end
