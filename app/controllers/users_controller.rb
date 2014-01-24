class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
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
      flash[:errors] = @user.errors.full_messages to_sentence
      render :new
    end
  end

  def edit
  end

  def update
    @user = User.find(user_params)
    @user.email = params[:user][:email]
    if @user.save
      flash[:success] = "Email was successfully saved"
      redirect_to user_path(@user)
    else
      flash[:errors] = @user.errors.full_messages to_sentence
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
