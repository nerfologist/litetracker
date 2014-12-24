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

    before :each do
      request.env['HTTP_ACCEPT'] = 'application/json'
      request.env['HTTP_CONTENT_TYPE'] = 'application/json'
    end

    after :each do
      expect(response.status).to eq(401) # unauthorized 
    end

    describe "GET #index" do
      it "requires login" do
        get :index
      end
    end

    describe "GET #show" do
      it "requires login" do
        get :show, { id: @project1 }
      end
    end

    describe "POST #create" do
      it "requires login" do
        post :create, { project: attributes_for(:project, owner: @user) }
      end
    end

    describe "PATCH #update" do
      it "requires login" do
        patch :update, { id: @project1, project: attributes_for(:project) }
      end
    end

    describe "DELETE #destroy" do
      it "requires login" do
        delete :destroy, { id: @project1 }
      end
    end
  end

  describe "user access" do
    before :each do
      @user = create(:user)
      emulate_login(@user)
      @project1 = create(:project, owner: @user)
      @project2 = create(:project, owner: @user)
      @project3 = create(:project)

      # emulate JSON request
      request.env['HTTP_ACCEPT'] = 'application/json'
      request.env['HTTP_CONTENT_TYPE'] = 'application/json'
    end

    after :each do
      expect(response.headers['Content-Type']).to match 'application/json'
    end

    describe "GET #index" do
      it "returns a list of the user's projects" do
        get :index, format: :json
        expect(JSON.parse(response.body)).to match_array(
          [JSON.parse(@project1.to_json),
           JSON.parse(@project2.to_json)]
        )
      end
    end
  end
end
