require 'rails_helper'
require 'byebug'

RSpec.describe Story, :type => :model do
  it "has a valid factory" do
    expect(build(:story)).to be_valid
  end

  it "is invalid without a tab" do
    t = build(:story, tab: nil)
    t.valid?
    expect(t.errors[:tab]).to include("can't be blank")
  end

  it "is invalid without a title" do
    t = build(:story, title: nil)
    t.valid?
    expect(t.errors[:title]).to include("can't be blank")
  end

  it "is invalid without a ord number" do
    t = build(:story, ord: nil)
    t.valid?
    expect(t.errors[:ord]).to include("can't be blank")
  end

  context "when enforcing ord uniqueness" do
    let(:s1) { create(:story, ord: 1) }

    it "ensures ord is unique in tab scope" do
      s2 = build(:story, tab: s1.tab, ord: 1)
      s2.valid?
      expect(s2.errors[:ord]).to include("has already been taken")
    end

    it "allows same ord in a different tab" do
      expect(build(:story, ord: 1)).to be_valid
    end
  end

  subject { build(:story) }

  it "ensures proper kind" do
    is_expected.to validate_inclusion_of(:kind).
      in_array(%w(feature bug chore release))
  end

  it "ensures proper points" do
    is_expected.to validate_inclusion_of(:points).
      in_array([1, 2, 3, 4, nil])
  end

  it "ensures proper state" do
    is_expected.to validate_inclusion_of(:state).
      in_array(%w(unstarted started finished accepted rejected))
  end

  it "ensures ord is >= 0" do
    is_expected.to validate_numericality_of(:ord).
      is_greater_than_or_equal_to(0)
  end

  it "ensures maximized is not nil" do
    is_expected.not_to allow_value(nil).for(:maximized)
  end

  it "falls back to 'unstarted' state if not declared" do
    expect(Story.new().state).to eq('unstarted')
  end
end
