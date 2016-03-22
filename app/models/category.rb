class Category < ActiveRecord::Base

  # Relationships to other models
  has_many :subcategories

  # Validations
  validates :name,  presence: true, uniqueness: true
end
