class SessionsController < ApplicationController
  skip_before_action :signed_in_user

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or dashboard_path
    else
      flash.now[:error] = "Invalid email/password combination"
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
