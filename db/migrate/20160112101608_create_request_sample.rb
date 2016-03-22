class CreateRequestSample < ActiveRecord::Migration
  def change
    create_table :request_samples do |t|
      t.string :seller_id
      t.string :requestee_id
      t.string :post_id
      t.string :delivery_location
    end
  end
end
