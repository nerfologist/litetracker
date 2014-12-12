require 'rails_helper'
require 'pry-byebug'

RSpec.describe SessionsController, :type => :controller do
  describe "GET #new" do
    before :each do
      get :new
    end

    it "assigns a new user to @user" do
      expect(assigns(:user)).to be_a_new(User) 
    end

    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before :all do
        @valid_user = create(:user)
      end

      before :each do
        post :create, user: {
          email: @valid_user.email,
          password: @valid_user.password
        }
      end

      it "signs in the user" do
        expect(session[:session_token]).not_to be_nil
      end

      it "redirects to the backbone start page" do
        expect(response).to redirect_to go_url
      end
    end

    context "with invalid attributes" do

    end
  end

  describe "DELETE #destroy" do

  end

  describe "#demo" do

  end
end
