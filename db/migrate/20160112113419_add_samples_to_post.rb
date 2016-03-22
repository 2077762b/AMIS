class AddSamplesToPost < ActiveRecord::Migration
  def change
    add_column :posts, :provide_samples, :boolean
  end
end
