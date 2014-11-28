require 'rails_helper'

RSpec.describe Project, :type => :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:project)).to be_valid
  end

  it "is invalid without a title" do
    expect(FactoryGirl.build(:project, title: nil)).not_to be_valid
  end

  it "is invalid without an owner" do
    expect(FactoryGirl.build(:project, owner: nil)).not_to be_valid
  end

  context "when enforcing title uniqueness" do
    it "enforces title uniqueness for an owner" do
      joe = FactoryGirl.create(:user)
      FactoryGirl.create(:project, title: 'my dup project', owner: joe)
      expect(FactoryGirl.build(:project, title: 'my dup project', owner: joe)).not_to be_valid 
    end

    it "does not enforce title uniqueness for different owners" do
      FactoryGirl.create(:project, title: "yet another dup project")
      expect(FactoryGirl.build(:project, title: "yet another dup project")).to be_valid
    end
  end
end
