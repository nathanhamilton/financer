class TransactionsController < ApplicationController
  before_action :signed_in_user
  before_filter :transaction, only: :edit

  def index
    @transactions = envelope.transactions
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = envelope.transactions.build(transaction_params)
    if @transaction.save
      flash[:success] = 'Transaction created'
      redirect_to envelopes_path
    else
      flash.now[:error] = @transaction.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if transaction.update(transaction_params)
      flash[:success] = 'Transaction updated'
      redirect_to envelopes_path
    else
      flash[:error] = transaction.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    transaction.destroy
    flash[:success] = "Transaction deleted"
    redirect_to envelopes_path
  end

  private

  def transaction_params
    params.require(:transaction).permit(:name, :transaction_type, :date, :amount, :user_id, :envelope_id)
  end

  def transaction
    @envelope ||= Transaction.find(params[:id])
  end
end