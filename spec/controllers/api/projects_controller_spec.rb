require 'rails_helper'

RSpec.describe Api::ProjectsController, :type => :controller do
  describe "guest access" do
    # no need to create them for every single example here
    # they won't be modified anyway (hopefully)
    before :all do
      @user = create(:user)
      @project1 = create(:project, owner: @user)
      @project2 = create(:project, owner: @user)
    end
    
    after(:all) do
      DatabaseCleaner.clean_with(:truncation)
    end
    
    after :each do
      expect(response).to redirect_to new_session_url
    end
    
    describe "GET #index" do
      it "requires login" do
        get :index
      end
    end
    
    describe "GET #show" do
      it "requires login" do
        get :show, id: @project1
      end
    end
    
    describe "POST #create" do
      it "requires login" do
        post :create, project: attributes_for(:project, owner: @user)
      end
    end
    
    describe "PATCH #update" do
      it "requires login" do
        patch :update, id: @project1, project: attributes_for(:project)
      end
    end
    
    describe "DELETE #destroy" do
      it "requires login" do
        delete :destroy, id: @project1
      end
    end
  end
  
  describe "user access" do
    before :each do
      emulate_login(create(:user))
    end
  end
end
