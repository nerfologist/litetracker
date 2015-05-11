module LoginMacros
  def login(user)
    visit new_session_path

    within '#user_form' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log In'
    end
  end

  def register(user)
    visit new_user_path

    within '#user_form' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Register'
    end
  end
end
