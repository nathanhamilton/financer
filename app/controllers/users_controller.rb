class UsersController < ApplicationController
  before_action :find_users, only: [:show, :create, :update]

  def index
    @users = User.all
  end

  def show
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
    @user.email = user_params[:email]
    binding.pry
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

  def find_users
    User.find(params[:id])
  end
end
