require 'rails_helper'

feature 'Welcome page' do
  background do
    visit root_path
  end

  scenario 'navbar buttons are present' do
    within 'nav.navbar' do
      expect(page).to have_content 'Log In'
      expect(page).to have_content 'Register'
    end
  end

  scenario 'page buttons are present' do
    within 'div#start-page-well-right' do
      expect(page).to have_content 'Log In'
      expect(page).to have_content 'Register'
      expect(page).to have_content 'Demo'
    end
  end

  scenario 'clicking Log In opens login page' do
    within 'div#start-page-well-right' do
      click_link 'Log In'
    end

    expect(page).to have_content 'Log In'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
  end

  scenario 'clicking Register opens register page' do
    within 'div#start-page-well-right' do
      click_link 'Register'
    end

    expect(page).to have_content 'Register'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
  end

  scenario 'clicking Demo logs the user in as Demo', js: true do
    create(:demo_user)

    within 'div#start-page-well-right' do
      click_link 'Demo'
    end

    expect(page).to have_content 'Projects'
    expect(page).to have_content 'Create project'
  end
end
