require 'rails_helper'

RSpec.describe StaticPagesController, :type => :controller do
  describe "GET #startpage" do
    it "renders the startpage template" do
      get :startpage
      expect(response).to render_template :startpage
    end
  end

  describe "GET #root" do
    context "when the user is signed in" do
      it "loads the root page" do
        #allow(controller).to receive(:require_signed_in!)
        emulate_login(create(:user))
        get :root
        expect(response).to render_template :root
      end
    end

    context "when the user is not signed in" do
      it "redirects to the login page" do
        get :root
        expect(response).to redirect_to new_session_url
      end
    end
  end
end
