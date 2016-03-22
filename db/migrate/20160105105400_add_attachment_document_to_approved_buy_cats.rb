class AddAttachmentDocumentToApprovedBuyCats < ActiveRecord::Migration
  def self.up
    change_table :approved_buy_cats do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :approved_buy_cats, :document
  end
end
