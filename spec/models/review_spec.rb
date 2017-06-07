require 'rails_helper'

RSpec.describe Review, type: :model do
  def valid_attributes(new_attributes = {})
    attributes = attributes_for(:review)
    attributes.merge(new_attributes)
  end

  describe 'Validations' do
    it 'requires a body' do
      review = Review.new(valid_attributes.merge({body: nil}))
      expect(review).to be_invalid
    end

    it 'requires a rating' do
      review = Review.new(valid_attributes.merge({rating: nil}))
      expect(review).to be_invalid
    end
  end

  describe 'Associations' do
    it "requires the review to be associated to a user" do
      review = Review.new(valid_attributes)
      review.user = nil
      expect(review).to be_invalid
    end

    it "requires the review to be associated to a product" do
      review = Review.new(valid_attributes)
      review.product = nil
      expect(review).to be_invalid
    end
  end
end
