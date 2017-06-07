require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  # defining users and categories
  let (:user) {FactoryGirl.create(:user)}
  let (:category) {FactoryGirl.create(:category)}

  def valid_request
    attributes = FactoryGirl.attributes_for(:product).merge(category_id: category.id)
    post :create, params: {product: attributes}
  end

  # We gaan nu de 'new' action (method) behandelen van de product controller
  describe "#new" do
    context "with no user signed in" do
      it "redirects to the sign in page" do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with user signed in" do
      # met onderstaande check je of iemand ingelogd is.
      before { request.session[:user_id] = user.id }
      before

      it "assign a product instance variable to be a new Product" do
        get :new
        # expect :new
        expect(assigns(:product)).to be_a_new(Product)
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#create" do
    context "with  no user signed in" do
      it "redirects to the sign in page" do
        post :create
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with signed in user" do
      # before { request.session[:user_id] = user.id }
      before {log_in(user)}

      context "with valid attributes" do

        it "creates a new product" do
          # This sentence is doing the same as the code below
          # expect {valid_request}.to change {Product.count}.by(1)
          count_before = Product.count
          valid_request
          count_after = Product.count
          expect(count_after).to eq(count_before + 1)
        end

        it "redirects to the product show page" do
          valid_request
          expect(response).to redirect_to(Product.last)
        end

        it "sets a flash notice message" do
          valid_request
          expect(flash[:notice]).to include('Product created')
        end

        it "associates the product to the user" do
          valid_request
          expect(Product.last.user).to eq(user)
        end

        it "associates the product to the category" do
          valid_request
          expect(Product.last.category).to eq(category)
        end
      end

      context "with invalid attributes" do
        def invalid_request
          post :create, params: {product: FactoryGirl.attributes_for(:product, title: nil )}
        end

        it "does not create a record in the database" do
          expect {invalid_request}.to change {Product.count}.by(0)
        end

        # it "does not create a record in the database part 2" do
        #   count_before = Product.count
        #   invalid_request
        #   count_after = Product.count
        #   expect(count_after).to eq(count_before)
        # end

        it "renders the new template" do
          invalid_request
          expect(response).to render_template(:new)
        end

        it "sets a flash message" do
          invalid_request
          expect(flash[:alert]).to include('Problem creating your product')
        end
      end
    end
  end
end
