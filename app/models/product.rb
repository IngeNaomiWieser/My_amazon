class Product < ApplicationRecord
  # The model defines all the logic around the data in the db
  # All the instances of the model get these methods (unless they are private or class methods)
  # So if a view gets an instance of a model as a variable (like @product)

  # Always define the belongs_to links on boths sides.
  #belongs to -> singular
  #has_many -> plural
  belongs_to :user
  belongs_to :category, optional: true     # with optional true, you can leave it blanco
  has_many :reviews, dependent: :destroy    #dependent: :destroy: -> if you delete the product, you will also delete the reviews that belong to it.

  has_many :favourites, dependent: :destroy
  has_many :admirers, through: :favourites, source: :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings 

  validates :title, presence: true, uniqueness: { case_sensitive: false}, exclusion: { in: %w(Apple Microsoft Sony)}
  validates :price, numericality: {greater_than_or_equal_to: 0}
  validates :description, length: { minimum: 10, message: 'not long enough' }

  after_initialize :set_defaults
  before_save :titleize_title
  before_destroy :warning

  def self.search(str)                 # class method
    where(['title || description ILIKE ?',
    "%#{str}%"]).order(title: :asc)
  end

  def increment_hit_count
    self.hit_count += 1
    self.save
  end

  def self.recent(number)
    order(created_at: :desc).limit(number)
  end

  private

  def set_defaults
    self.price ||= 1 # If the price is not given (which it should be... see validations), the price will be 1
    self.sale_price ||= self.price # if sale price is not given, it's the same as the price
    self.hit_count ||= 0     #if the hitcount is not given, it's 0
  end

  def titleize_title
    self.title = self.title.titleize
  end

  def warning
    puts "Product is about to be deleted"
  end

end
