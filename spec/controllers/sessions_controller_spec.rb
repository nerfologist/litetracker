require 'rails_helper'

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
    before :all do
      @valid_user = create(:user)
    end

    after :all do
      @valid_user.destroy
    end

    context "with valid attributes" do
      before :each do
        post :create, user: {
          email: @valid_user.email,
          password: @valid_user.password
        }
      end

      it "finds and assigns the user to current_user" do
        expect(assigns[:current_user]).to eq(@valid_user)
      end

      it "sets the session token in the cookie" do
        expect(session[:session_token]).not_to be_nil
      end

      it "redirects to the backbone start page" do
        expect(response).to redirect_to go_url
      end
    end

    context "with invalid attributes" do
      before :each do
        post :create, user: {
          email: Faker::Internet.email,
          password: Faker::Internet.password(8)
        }
      end

      it "does not set any user to current_user" do
        expect(assigns[:current_user]).to be_nil
      end

      it "does not set the session token in the cookie" do
        expect(session[:session_token]).to be_nil
      end

      it "redirects to the new session page" do
        expect(response).to redirect_to new_session_url
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      delete :destroy
    end

    it "sets the session token in the cookie to nil" do
      expect(session[:session_token]).to be_nil
    end

    it "redirects to the root url" do
      expect(response).to redirect_to root_url
    end
  end

  describe "GET #demo" do
    it "redirects to the backbone start page" do
      create(:demo_user)
      get :demo
      expect(response).to redirect_to go_url
    end
  end
end
