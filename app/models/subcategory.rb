class Subcategory < ActiveRecord::Base

  # Relationships to other models
  belongs_to :category
  has_many :posts
  has_many :approved_sell_cats
  has_many :traders, through: :approved_sell_cats
  has_many :approved_buy_cats
  has_many :traders, through: :approved_buy_cats

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :category_id, presence: true
end
