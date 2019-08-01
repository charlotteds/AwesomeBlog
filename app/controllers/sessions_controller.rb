class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])

    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      flash[:info] = "Successfully logged in."
      redirect_to root_url
    else
      flash.now[:danger] = "Invalid Credentials"
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:info] = "Successfully logged out."

    redirect_to root_url
  end
end
