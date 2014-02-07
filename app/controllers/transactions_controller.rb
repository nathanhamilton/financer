class TransactionsController < ApplicationController
  before_action :signed_in_user
  before_filter :transaction, only: :edit
  before_filter :envelope, only: [:new, :edit]

  def index
    @transactions = envelope.transactions
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = envelope.transactions.build(transaction_params)
    @transaction.user_id = current_user.id
    if @transaction.save
      flash[:success] = 'Transaction created'
      redirect_to envelope_transactions_path(envelope)
    else
      flash.now[:error] = @transaction.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if transaction.update(transaction_params)
      flash[:success] = 'Transaction updated'
      redirect_to envelope_transactions_path(envelope)
    else
      flash[:error] = transaction.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    transaction.destroy
    flash[:success] = "Transaction deleted"
    redirect_to envelope_transactions_path(envelope)
  end

  private

  def envelope
    @envelope ||= Envelope.find(params[:envelope_id])
  end

  def transaction
    @transaction ||= Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:name, :transaction_type, :date, :amount, :user_id, :envelope_id)
  end
end
