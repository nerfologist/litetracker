require 'rails_helper'

feature 'Signing in' do
  let(:user) { create(:user) }

  context 'as an existing user', js: true do
    scenario 'it shows the projects page' do
      login user

      expect(page).to have_content 'Projects'
    end
  end

  context 'with wrong credentials' do
    before(:each) { login build(:user) }

    scenario 'it displays an error' do
      expect(page).to have_content 'invalid credentials'
    end

    scenario 'it renders the login form' do
      expect(page).to have_css 'form#user_form'
    end
  end
end
