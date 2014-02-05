class BanksController < ApplicationController
  before_action :signed_in_user, except: [:new, :create]
  before_action :bank, only: :edit

  def new
    @bank = Bank.new
  end

  def create
    bank = current_user.banks.build(bank_params)
    if bank.save
      flash[:success] = "Bank Created!"
      redirect_to dashboard_path
    else
      flash.now[:error] = bank.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    bank.update(bank_params)
    if bank.save
      flash[:success] = "Bank has been updated!"
      redirect_to dashboard_path
    else
      flash.now[:error] = bank.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    bank.delete
    flash[:success] = "Bank has been deleted"
    redirect_to dashboard_path
  end

  private

  def bank_params
    params.require(:bank).permit(:name)
  end

  def bank
    @bank ||= Bank.find(params[:id])
  end
end
