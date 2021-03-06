desc 'Move transactions from under envelopes to under banks'
task move_transactions_under_banks: :environment do

  pb = ProgressBar.new('Transactions', Transaction.all.count)

  Transaction.all.each do |transaction|
    bank_id = transaction.envelope.bank_id
    transaction.institutionable_id = bank_id
    transaction.institutionable_type = Bank
    transaction.save
    pb.inc
  end
  pb.finish
end

desc 'add user ids to envelopes that have a user id of nil'
task add_user_id_to_nil_envelopes: :environment do

  pb = ProgressBar.new('Envelopes', Envelope.all.count)

  Envelope.all.each do |envelope|
    bank_present = Bank.all.ids.include?(envelope.bank_id)
    if envelope.user_id == nil && bank_present
      envelope.user_id = Bank.find(envelope.bank_id).user_id
      envelope.save
    end
    pb.inc
  end
  pb.finish
end
