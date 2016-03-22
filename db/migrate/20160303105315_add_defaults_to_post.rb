class AddDefaultsToPost < ActiveRecord::Migration
  def change
	change_column(:posts, :private, :boolean, :default => false)
	change_column(:posts, :delivery, :boolean, :default => false)  	  	
  end
end
