class TransactionManager

  attr_accessor :errors

  def initialize(params, envelope, user_id)
    @params = params
    @envelope = envelope
    @user_id = user_id
    @errors = []
  end

  def error_messages
    errors.join(', ')
  end

  def create
    values_exist?
    check_name_length
    errors.blank? ? create_transaction : false
  end

  private

  attr_accessor :params, :user_id, :envelope

  def create_transaction
    Transaction.transaction do
      Transaction.create!(name: params[:name],
                          amount: params[:amount],
                          transaction_type: params[:transaction_type],
                          date: Date.strptime(params[:date].to_s, "%m/%d/%Y"),
                          user_id: user_id,
                          envelope_id: envelope.id,
                          institutionable_id: params[:institutionable_id],
                          institutionable_type: 'Bank')
    # The institutionable assignment is only temporary until credit cards are instituted
    end
  end

  def check_name_length
    if params[:name].length > 100
      errors << 'The name you have submitted is longer than 100 characters'
    end
  end

  def values_exist?
    params.each do |key, value|
      if value == nil
        errors << "#{key} cannot be empty"
      end
    end
  end
end
