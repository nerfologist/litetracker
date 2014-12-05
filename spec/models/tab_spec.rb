require 'rails_helper'

RSpec.describe Tab, :type => :model do
  it "has a valid factory" do
    expect(build(:tab)).to be_valid
  end

  it "is invalid without a name" do
    t = build(:tab, name: nil)
    t.valid?
    expect(t.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a ord" do
    t = build(:tab, ord: nil)
    t.valid?
    expect(t.errors[:ord]).to include("can't be blank")
  end

  it "is invalid when ord is negative" do
    expect(build(:tab, ord: rand(-256..0))).not_to be_valid
  end

  it "is invalid without a project" do
    t = build(:tab, project: nil)
    t.valid?
    expect(t.errors[:project]).to include("can't be blank")
  end

  it "is invalid without visible" do
    t = build(:tab, visible: nil)
    t.valid?
    expect(t.errors[:visible]).to include("is not included in the list")
  end

  context "when given a name" do
    let(:t) { create(:tab) }

    it "does not share a name with other tabs in the same project" do
      t2 = build(:tab, name: t.name, project: t.project) 
      t2.valid?
      expect(t2.errors[:name]).to include("has already been taken")
    end

    it "can share a name with tabs from other projects" do
      t2 = build(:tab, name: t.name)
      expect(t2).to be_valid
    end
  end
end
