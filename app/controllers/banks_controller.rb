class BanksController < ApplicationController
  before_action :find_bank, only: [:edit, :update, :destroy]

  def new
    @bank = Bank.new
  end

  def create
    @bank = current_user.banks.build(bank_params)
    if @bank.save
      flash[:success] = "Bank Created!"
      redirect_to user_path(current_user)
    else
      flash.now[:error] = @bank.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @bank.update(bank_params)
    if @bank.save
      flash[:success] = "Bank has been updated!"
      redirect_to user_path(current_user)
    else
      flash.now[:error] = @bank.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @bank.delete
    flash[:success] = "Bank has been deleted"
    redirect_to user_path(current_user)
  end

  private

  def bank_params
    params.require(:banks).permit(:name)
  end

  def find_bank
    @bank = Bank.find(params[:id])
  end
end