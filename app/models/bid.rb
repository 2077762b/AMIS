class Bid < ActiveRecord::Base

  # Relationships to other models
  belongs_to :post

  # Validations
  validates :amount,  presence: true


end