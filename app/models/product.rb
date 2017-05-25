class Product < ApplicationRecord
  belongs_to :category
  has_many :reviews, dependent: :destroy


  validates :title, presence: true, uniqueness: { case_sensitive: false}, exclusion: { in: %w(Apple Microsoft Sony)}
  validates :price, numericality: {greater_than_or_equal_to: 0}
  validates :description, length: { minimum: 10, message: 'not long enough' }

  after_initialize :set_defaults
  before_save :titleize_title
  before_destroy :warning

  def self.search(str)
    where(['title || description ILIKE ?',
    "%#{str}%"]).order(title: :asc)
  end

  def increment_hit_count
    self.hit_count += 1
    self.save
  end

  private

  def set_defaults
    self.price ||= 1
    self.sale_price ||= self.price
    self.hit_count ||= 0
  end

  def titleize_title
    self.title = title.titleize
  end

  def warning
    puts "Product is about to be deleted"
  end

end
