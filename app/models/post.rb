class Post < ActiveRecord::Base

  # Set the delivery days to 5 if delivery is not provided
  before_save :default_values

  # Relationships to other models
  belongs_to :trader
  belongs_to :subcategory
  has_many :bids

  # Validations
  has_attached_file :image, styles: { medium: "250x200!", small: "75x50!"}, default_url: "/images/iron.png"
  is_impressionable :counter_cache => true, :column_name => :views, :unique => :request_hash
  validates :name,  presence: true, length: {maximum: 128}
  validates :description,  presence: true, length: {maximum: 256}
  validates :quantity,  presence: true
  validates :price,  presence: true
  validates :subcategory_id,  presence: true
  validates :image,  presence: true
  validates :delivery_days, presence: true, if: :delivery?
  validates :line1, presence: true
  validates :city, presence: true
  validates :county, presence: true
  validates :postcode, presence: true, length: {minimum: 4, maximum: 10}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/


  # Is the seller providing delivery
  def delivery?
    self.delivery
  end

  # Returns the post whose titles contain one or more words that form the query
  def self.search(query)
    Post.joins(:subcategory).where('posts.name LIKE :search
                                       OR posts.description LIKE :search
                                       OR subcategories.name LIKE :search' ,search: "%#{query}%") +
        Post.joins(:trader).where(private: 'false').where('traders.username LIKE :search',search: "%#{query}%")
  end

  # If delivery is not provided set the delivery days to 5
  def default_values
    if !(delivery?)
      self.delivery_days ||= '5'
    end
  end

end
