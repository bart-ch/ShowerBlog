class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = 'You have successfully logged in.'
      redirect_to user_path(user)
    else
      flash.now[:notice] = 'Invalid credentials'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You have logged out.'
    redirect_to root_path
  end
end
