class UsersController < ApplicationController
  skip_before_action :signed_in_user, only: [:new, :create]
  before_action :user, except: [:index, :new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to financer!"
      redirect_to dashboard_path
    else
      flash.now[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @banks = @user.banks
  end

  def update
    if user.update(user_params)
      flash[:success] = "Your information was successfully saved"
      redirect_to dashboard_path
    else
      flash.now[:error] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    user.destroy
    flash[:success] = "User has been deleted"
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end

  def user
    @user ||= User.find(params[:id])
  end
end
