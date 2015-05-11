module EmulateLoginMacros
  def emulate_login(user)
    session[:session_token] = user.session_token
  end
end
