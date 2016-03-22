class ApprovedBuyCat < ActiveRecord::Base

  # Relationships to other models
  belongs_to :trader
  belongs_to :buy_cat, class_name: 'Subcategory'

  # Validations
  validates :document, presence: true
  has_attached_file :document, styles: {thumbnail: "60x60#"}
  validates_attachment :document, content_type: { content_type: "application/pdf" }, size: { in: 0..5.megabytes }

end
