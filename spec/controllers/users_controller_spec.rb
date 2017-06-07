require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#new" do
    before { get :new }

    it "instantiates a new user variable" do
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the new template" do
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "with valid params" do
      def valid_request
        post :create, params: { user: attributes_for(:user) }
      end

      it "creates a user in the database" do
        count_before = User.count
        valid_request
        count_after = User.count
        expect(count_after).to eq(count_before + 1)
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end

      it "redirects to the root path" do
        valid_request
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      def invalid_request
        post :create, params: { user: attributes_for(:user).merge({email: nil}) }
      end

      it "does not create a user in the database" do
        count_before = User.count
        invalid_request
        count_after = User.count
        expect(count_after).to eq(count_before)
      end

      it "sets a flash message" do
        invalid_request
        expect(flash[:alert]).to be
      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end
    end
  end
end
