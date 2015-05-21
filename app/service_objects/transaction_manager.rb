class TransactionManager

  attr_accessor :params, :envelope

  def initialize(params, envelope)
    @params = params
    @envelope = envelope
  end

  def create
    errors.blank? ? create_transaction : false
  end

  private

  def create_transaction

  end
end
