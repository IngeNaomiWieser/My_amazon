require 'rails_helper'

RSpec.describe User, type: :model do
  def valid_attributes(new_attributes = {})
    attributes = attributes_for(:user)
    attributes.merge(new_attributes)
  end

  describe "Validations" do
    it "requires a first name" do
      user = User.new(valid_attributes({first_name: nil}))
      expect(user).to be_invalid
    end

    it "requires a last name" do
      user = User.new(valid_attributes({last_name: nil}))
      expect(user).to be_invalid
    end

    it "requires a email" do
      user = User.new(valid_attributes({email: nil}))
      expect(user).to be_invalid
    end

    it "requires a unique email" do
      User.create(valid_attributes({email: "buddy@example.com"}))
      user = User.new(valid_attributes({email: "buddy@example.com"}))
      user.save
      expect(user.errors.messages).to have_key(:email)
    end
  end

  describe "full_name" do
    it "returns the first_name and last_name concatenated" do
      fullname = "#{valid_attributes[:first_name]} #{valid_attributes[:last_name]}"
      user = User.new(valid_attributes)
      expect(user.full_name).to eq(fullname)
    end

    it "returns the first_name and last_name titleized" do
      user = User.new(valid_attributes({first_name: "carlo", last_name: "villeneuava"}))
      expect(user.full_name).to eq("Carlo Villeneuava")
    end
  end
end
