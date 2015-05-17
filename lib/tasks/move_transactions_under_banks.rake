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
