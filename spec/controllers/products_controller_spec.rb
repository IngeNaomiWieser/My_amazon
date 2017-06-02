require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
    describe "#new" do
        context "with no user signed in" do
        it "redirects to the sign in page" do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with user signed in" do
      before { request.session[:user_id] = user.id }

      it "assign a product instance variable to be a new Product" do
        get :new
        expect :new
        expect(assigns(:product)).to be_a_new(Product)
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end
  end
end
