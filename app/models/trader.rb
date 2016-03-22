class Trader < ActiveRecord::Base

  # Relationships to other models
  has_many :posts
  has_many :approved_sell_cats
  has_many :sell_cats, :through =>  :approved_sell_cats
  has_many :approved_buy_cats
  has_many :buy_cats, :through =>  :approved_buy_cats
  has_many :trades
  belongs_to :picture

  # Validations
  validates :username, presence: true, uniqueness: true, length: {maximum: 128}
  validates :email, length: {maximum: 254}

  # Include default devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


end
