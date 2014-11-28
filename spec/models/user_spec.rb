require 'rails_helper'
require 'faker'

RSpec.describe User, :type => :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it "is invalid without an email" do
    expect(FactoryGirl.build(:user, email: nil)).not_to be_valid
  end

  it "is invalid with a blank password" do
    # user password is allowed to be nil, as only the password digest is
    # stored on the DB. Not allowing nil would not allow instances to
    # validate after creation.
    expect(FactoryGirl.build(:user, password: "")).not_to be_valid
  end

  it "is invalid with a password shorter than 6 chars" do
    expect(FactoryGirl.
           build(:user,
                 password: Faker::Internet.password(0, 5))
          ).not_to be_valid
  end

  it "can be found by his credentials after creation" do
    u = FactoryGirl.create(:user)
    expect(User.find_by_credentials(
      email: u.email,
      password: u.password)
          ).to eq(u)
  end

  context "when checking passwords against his own" do
    let(:user) { FactoryGirl.create(:user) }

    it "returns false in case of wrong password" do
      # test with randomly generated password
      expect(user.is_password?(Faker::Internet.password)).to be false
    end

    it "returns true in case of good password" do
      expect(user.is_password?(user.password)).to be true
    end
  end
end
