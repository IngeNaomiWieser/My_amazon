require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:user) { create(:user) }
  let(:reviewer) { create(:user) }
  let(:product) { create(:product) }
  let!(:review) { create(:review, product: product, user: reviewer) }

  describe '#create' do
    context 'user not logged in' do
      it "redirects to the log in page" do
        post :create, params: { review: attributes_for(:review), product_id: product.id }
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'user (the reviewer) is logged in' do
      before { log_in(reviewer) }

      context 'valid params' do
        def valid_request
          post :create, params: { review: attributes_for(:review), product_id: product.id }
        end

        it 'creates a new review in the database' do
          count_before = Review.count
          valid_request
          count_after = Review.count
          expect(count_after).to eq(count_before + 1)
        end

        it 'sets a flash message' do
          valid_request
          expect(flash[:notice]).to be
        end

        it 'redirects to the product show page' do
          valid_request
          expect(response).to redirect_to(product_path(product))
        end

        it 'associates the review to the user/reviewer' do
          valid_request
          expect(Review.last.user).to eq(reviewer)
        end

        it 'associates the review to the product' do
          valid_request
          expect(Review.last.product).to eq(product)
        end
      end

      context 'invalid params' do
        def invalid_request
          post :create, params: {review: {rating: nil}, product_id: product.id}
        end

        it "does not create a record in the database" do
          count_before = Review.count
          invalid_request
          count_after = Review.count
          expect(count_after).to eq(count_before)
        end

        it "renders the new template" do
          invalid_request
          expect(response).to render_template('products/show')
        end

        it "sets a flash message" do
          invalid_request
          expect(flash[:alert]).to be
        end
      end
    end
  end

  describe "#destroy" do
    context "with user not logged in" do
      it "redirects to the sign in page" do
        delete :destroy, params: { id: review.id, product_id: product.id }
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with user logged in" do
      context "with non creator/reviewer signed in" do
        before do
          # this user is not the creator, its someone else
          log_in(user)
          delete :destroy, params: {id: review.id, product_id: product.id}
        end

        it "redirects to the product show page" do
          expect(response).to redirect_to(product_path(product))
        end

        it "sets a flash alert message" do
          expect(flash[:alert]).to be
        end
      end

      context 'with review creator logged in' do
        def valid_request
          delete :destroy, params: {id: review.id, product_id: product.id}
        end

        before {log_in(reviewer)}

        it "destroys a review from the database" do
          count_before = Review.count
          valid_request
          count_after = Review.count
          expect(count_after).to eq(count_before - 1)
        end

        it "redirects to the product show page" do
          valid_request
          expect(response).to redirect_to(product_path(product))
        end

        it 'sets a flash notice message' do
          valid_request
          expect(flash[:notice]).to be
        end
      end
    end
  end
end
