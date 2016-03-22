class Request_Sample < ActiveRecord::Base

  # Relationships to other models
  belongs_to :post
  belongs_to :trader
  belongs_to :requestee, class_name: 'Trader'


validates :post_id, presence: true
validates :requestee_id, presence: true
validates :seller_id, presence: true



end