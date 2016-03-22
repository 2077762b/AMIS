class AddAttachmentDocumentToApprovedSellCats < ActiveRecord::Migration
  def self.up
    change_table :approved_sell_cats do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :approved_sell_cats, :document
  end
end
