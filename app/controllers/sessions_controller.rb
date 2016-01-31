class SessionsController < ApplicationController

  def new



  end


  def create
  	user = User.find_by(email: params[:session][:email].to_s.downcase)
  	if user && user.authenticate(params[:session][:password])
  	   session[:user_id] = user.id
  	   flash[:success] = "Welcome back #{user.username}. You have successfully signed in"
  	   redirect_to user_path(user)
  	else
  	  flash.now[:danger] = "Oops. There was something wrong with your login information."
  	  render 'new'
  	end

  end

  def destroy
  	session[:user_id] = nil
  	flash[:success] = "You have logged out"
  	redirect_to root_path

  end


end
