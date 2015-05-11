require 'rails_helper'

feature 'Registering' do
  context 'with good new credentials' do
    let(:user) { build(:user) }

    scenario 'it creates the new user' do
      expect { register user }.to change(User, :count).by(1)
    end

    scenario 'it shows the projects page', js: true do
      register user

      expect(page).to have_content 'Projects'
    end
  end

  context 'using an existing email' do
    let(:user) { create(:user) }

    before :each do
      register build(:user, email: user.email)
    end

    scenario 'it displays an error' do
      expect(page).to have_content 'Email has already been taken'
    end

    scenario 'it renders the login form' do
      expect(page).to have_css 'form#user_form'
    end
  end
end
