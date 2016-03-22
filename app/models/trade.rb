class Trade < ActiveRecord::Base

  # Relationships to other models
  belongs_to :post
  belongs_to :trader

  # Validations
  validates :post_id, presence: true
  validates :trader_id, presence: true
  validates :time, presence: true
  


end