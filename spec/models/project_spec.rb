require 'rails_helper'

RSpec.describe Project, :type => :model do
  it "has a valid factory" do
    expect(create(:project)).to be_valid
  end

  it "is invalid without a title" do
    p = build(:project, title: nil)
    p.valid?
    expect(p.errors[:title]).to include("can't be blank")
  end

  it "is invalid without an owner" do
    p = build(:project, owner: nil)
    p.valid?
    expect(p.errors[:owner]).to include("can't be blank")
  end

  context "when enforcing title uniqueness" do
    it "enforces it for an owner" do
      joe = create(:user)
      create(:project, title: 'my dup project', owner: joe)
      bad_p = build(:project, title: 'my dup project', owner: joe)
      bad_p.valid?
      expect(bad_p.errors[:title]).to include("has already been taken")
    end

    it "does not enforce it for different owners" do
      create(:project, title: "yet another dup project")
      expect(build(:project, title: "yet another dup project")).to be_valid
    end
  end
end
