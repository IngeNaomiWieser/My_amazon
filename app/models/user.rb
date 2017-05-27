class User < ApplicationRecord

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: VALID_EMAIL_REGEX

  has_many :products, dependent: :nullify
  has_many :reviews, dependent: :nullify

  def full_name
    "#{first_name} #{last_name}"
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
