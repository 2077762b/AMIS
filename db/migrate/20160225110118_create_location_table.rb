class CreateLocationTable < ActiveRecord::Migration
  def change
    create_table :location do |t|
      t.string :address1
      t.string :address2
      t.string :city
      t.string :postcode
    end
  end
end
