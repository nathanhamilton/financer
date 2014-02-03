class BanksController < ApplicationController

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

  def show
    @bank = Bank.find(params[:id])
  end

  def update
    @bank = Bank.find(params[:id])
    @bank.update(bank_params)
    if @bank.save
      flash[:success] = "Bank has been updated!"
      redirect_to user_path(current_user)
    else
      flash.now[:error] = @bank.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def bank_params
    params.require(:bank).permit(:name)
  end
end
