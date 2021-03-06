class Picture < ActiveRecord::Base

  # Relationships to other models
  has_many :traders

  # Validations
  validates :image, presence: true
  has_attached_file :image, styles: { medium: "200x200#" }, default_url: "rsz_profile.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

end
