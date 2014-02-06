class TransactionsController < ApplicationController

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

  private

  def transaction_params
    params.require(:transaction).permit(:name, :transaction_type, :date, :amount, :user_id, :envelope_id)
  end
end
