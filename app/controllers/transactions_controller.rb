class TransactionsController < ApplicationController
  before_action :transaction, only: :edit
  before_action :envelope, only: [:index, :new, :edit]
  before_action :banks, only: [:index, :new, :edit]

  def index
    @transactions = Transaction.includes(:institutionable).by_envelope(params).order(date: :desc).page(params[:page]).per(15)
  end

  def new
    @transaction = Transaction.new
  end

  def create
    manager = TransactionManager.new(transaction_params, envelope, current_user.id)
    if manager.create
      flash[:success] = 'Transaction created'
      redirect_to envelope_transactions_path(envelope)
    else
      flash.now[:error] = manager.error_messages
      @banks = current_user.banks
      render :new
    end
  end

  def update
    if transaction.update(transaction_params)
      flash[:success] = 'Transaction updated'
      redirect_to envelope_transactions_path(envelope)
    else
      @envelope = envelope
      @banks = banks
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

  def banks
    @banks = current_user.banks
  end

  def transaction_params
    params.require(:transaction).permit(:name, :transaction_type, :minical_date,
                                        :amount, :user_id, :envelope_id,
                                        :institutionable_id, :institutionable_type)
  end
end
