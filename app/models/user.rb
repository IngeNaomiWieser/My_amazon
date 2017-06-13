class User < ApplicationRecord

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  has_many :products, dependent: :nullify
  has_many :reviews, dependent: :nullify

  has_many :favourites, dependent: :destroy
  has_many :favourited_products, through: :favourites, source: :product

  has_many :likes, dependent: :destroy
  has_many :liked_reviews, through: :likes, source: :review

  has_many :votes, dependent: :destroy
  has_many :voted_reviews, through: :votes, source: :review 

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

  before_validation :downcase_email

  def full_name
    "#{first_name} #{last_name}".strip.titleize
  end

  def downcase_email
    self.email&.downcase!
  end

  # def self.search(string)
  #   where("first_name ILIKE ?", "%#{string}%").or(
  #   where("last_name ILIKE ?", "%#{string}%").or(
  #   where("email ILIKE ?", "%#{string}%"))).order(first_name: :asc)
  # end
  #
  # def self.search_not(string)
  #   where("first_name NOT ILIKE ?", "%#{string}%")
  #   .where("last_name NOT ILIKE ?", "%#{string}%").order(id: :asc)
  # end

end
