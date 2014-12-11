require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  describe "GET #new" do
    it "assigns a new user to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new user in the database" do
        expect{ post :create, user: attributes_for(:user) }.to change(
          User, :count
        ).by(1)
      end

      it "redirects to the main backbone page" do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to(go_url)
      end
    end

    context "with invalid attributes" do
      it "does not save the new user in the database" do
        expect {
          post :create, user: attributes_for(:user_no_email)
        }.not_to change(User, :count)
      end

      it "re-renders the :new template" do
        post :create, user: attributes_for(:user_no_email)
        expect(response).to render_template :new
      end
    end
  end
end
