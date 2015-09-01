class BanksController < ApplicationController
  before_action :bank, only: :edit
  before_action :banks

  def show
    @bank = Bank.find(params[:id])
    @transactions = Transaction.includes(:institutionable)
                               .where(institutionable_id: @bank.id)
                               .order(date: :desc)
                               .page(params[:page])
                               .per(15)
  end

  def new
    @bank = Bank.new
  end

  def create
    bank = current_user.banks.new(bank_params)
    if bank.save
      flash[:success] = "Bank Created!"
      redirect_to dashboard_path
    else
      flash.now[:error] = bank.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if bank.update(bank_params)
      flash[:success] = "Bank has been updated!"
      redirect_to dashboard_path
    else
      flash.now[:error] = bank.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    Transaction.where(institutionable_id: bank.id).delete_all
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

  def banks
    @banks ||= current_user.banks
  end
end
