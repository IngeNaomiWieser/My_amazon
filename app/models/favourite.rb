class Favourite < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :user_id, uniqueness: {
    scope: :product_id,
    message: 'This is already a favourite of yours'
  }
end
