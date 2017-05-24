require 'rails_helper'

RSpec.describe Product, type: :model do
  def valid_attributes(new_attributes)
    attributes = {
      title: 'Chair',
      description: 'Comfy and cheap',
      price: 50
    }
    attributes.merge(new_attributes)
  end

  describe "validation" do
    context "title" do
      it "requires a title" do
        product = Product.new(  valid_attributes({ title: nil })  )
        expect(product).to be_invalid
      end

      it "requires an unique title" do
        product1 = Product.new(valid_attributes({ title: 'Fancy Office Chair' }))
        product2 = Product.new(valid_attributes({ title: 'Fancy Office Chair' }))
        product1.save
        expect(product2).to be_invalid
      end

      it "titleizes the title after getting saved" do
        product = Product.new(valid_attributes(title: 'ice cream'))
        product.save
        expect(product.title).to eq('Ice Cream')
      end
    end

    context "description" do
      it "requires a description" do
        product = Product.new(valid_attributes({ description: '' }))
        product.save
        expect(product).to be_invalid
      end

      # OR :

      it "requires a description" do
        product = Product.new(valid_attributes({ description: '' }))
        product.valid?

        expect(product.errors[:description]).to be
        expect(product.errors.has_key?(:description)).to eq(true)
      end
    end

    context "price" do
      it "requires a price" do
        product = Product.new(valid_attributes({ price: '' }))
        product.valid?
        expect(product.errors[:price]).to be
      end

      it "is more than 0" do
        product = Product.new( valid_attributes({ price: -1 }))
        product.valid?
        expect(product.errors).to have_key(:price)
      end
    end
  end

  describe "search" do
    it "finds product by title" do
      product = Product.new(valid_attributes({}))
      product.save
      r1 = Product.search('Chair')
      r2 = Product.search('something which does not exist')
      expect(r1.size).to be(1)
      expect(r2.size).to be(0)
    end

    it "finds product by description" do
      product = Product.new(valid_attributes({}))
      product.save
      r1 = Product.search('Comfy and cheap')
      r2 = Product.search('Something that does not exit')
      expect(r1.size).to be(1)
      expect(r2.size).to be(0)
    end

    # Als je een `.where()` doet krijg je een _active record relation_, dat is een soort array met alle _records_ die voldoen aan de `.where()` query. Die "array" kan leeg zijn als er geen enkele record is die aan de query voldoet.
    # In je test geval had je maar 1 record en je zocht op de titel van dat/die record, dus de search funtion zou je een "array" moeten geven met 1 record
    # In het tweede geval zocht je op een niet bestaande string, dus zou je een lege _active record relation_ moeten krijgen

  end
end
