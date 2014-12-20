require 'rails_helper'

RSpec.describe User, :type => :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without an email" do
    u = build(:user, email: nil)
    u.valid?
    expect(u.errors[:email]).to include("can't be blank")
  end

  it "has a unique email address" do
    u = create(:user)
    u2 = build(:user, email: u.email)
    u2.valid?
    expect(u2.errors[:email]).to include("has already been taken")
  end

  it "is invalid with a blank password" do
    # user password is allowed to be nil, as only the password digest is
    # stored on the DB. Not allowing nil would not allow instances to
    # validate after creation.
    u = build(:user, password: "")
    u.valid?
    expect(u.errors[:password]).to include("is too short (minimum is 6 characters)")
  end

  it "is invalid with a password shorter than 6 chars" do
    u = build(
      :user,
      password: Faker::Internet.password(0,5))
    u.valid?
    expect(u.errors[:password]).to include("is too short (minimum is 6 characters)")
  end

  it "can be found by his credentials after creation" do
    u = create(:user)
    expect(User.find_by_credentials(
      email: u.email,
      password: u.password)
          ).to eq(u)
  end

  context "when checking passwords against his own" do
    let(:user) { create(:user) }

    it "returns false in case of wrong password" do
      # test with randomly generated password
      expect(user.is_password?(Faker::Internet.password)).to be false
    end

    it "returns true in case of good password" do
      # test with real password
      expect(user.is_password?(user.password)).to be true
    end
  end
end
