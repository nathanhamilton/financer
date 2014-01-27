class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Your account was created successfully"
      redirect_to user_path(@user)
    else
      flash[:errors] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Email was successfully saved"
      redirect_to user_path(@user)
    else
      flash[:errors] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User has been deleted"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :name)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
