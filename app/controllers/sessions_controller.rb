class SessionsController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    user = User.find_by_credentials(params[:user])
   if user
     sign_in!(user)
     redirect_to go_url
   else
     flash[:errors] = ['invalid credentials']
     redirect_to new_session_url
   end
  end
  
  def destroy
    sign_out!
    redirect_to root_url
  end
  
  def demo
    user = User.find_by(email: 'demo@users.com')
    sign_in!(user)
    redirect_to go_url
  end
end
