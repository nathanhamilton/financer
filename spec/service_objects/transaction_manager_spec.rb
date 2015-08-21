require 'rails_helper'

describe TransactionManager do
  describe 'create' do

    context 'success' do
      let!(:user) { FactoryGirl.create :user }
      let!(:envelope) { FactoryGirl.create :envelope, user_id: user.id }
      let!(:bank) { FactoryGirl.create :bank }

      before do
        @params = {
          name: 'Wonderworld groceries',
          transaction_type: 'Debit',
          minical_date: '08/03/2015' ,
          amount: 40.00 ,
          institutionable_id: bank.id,
          institutionable_type: 'Bank'
        }
      end

      let!(:manager) { TransactionManager.new(@params, envelope, user.id) }

      it 'creates a new transaction' do
        expect do
          manager.create
        end.to change { Transaction.count }.by 1
      end
    end

    context 'failure' do
      context 'when then name is too long' do
        let!(:user) { FactoryGirl.create :user }
        let!(:envelope) { FactoryGirl.create :envelope, user_id: user.id }
        let!(:bank) { FactoryGirl.create :bank }

        before do
          @params = {
            name: 'a' * 150,
            transaction_type: 'Debit',
            date: '08/03/2015',
            amount: 40.00 ,
            institutionable_id: bank.id,
            institutionable_type: 'Bank'
          }
        end

        let!(:manager) { TransactionManager.new(@params, envelope, user.id) }

        it 'should not create a transaction' do
          expect do
            manager.create
          end.to change { Transaction.count }.by 0
        end

        it 'should return the name length error' do
          manager.create
          expect(manager.errors[0]).to eq 'The name you have submitted is longer than 100 characters'
        end
      end

      context 'when an attribute is missing' do
        let!(:user) { FactoryGirl.create :user }
        let!(:envelope) { FactoryGirl.create :envelope, user_id: user.id }
        let!(:bank) { FactoryGirl.create :bank }

        before do
          @params = {
            name: 'Wonderworld Groceries',
            transaction_type: 'Debit',
            date: Date.today,
            amount: nil,
            institutionable_id: bank.id,
            institutionable_type: 'Bank'
          }
        end

        let!(:manager) { TransactionManager.new(@params, envelope, user.id) }

        it 'should not create a transaction' do
          expect do
            manager.create
          end.to change { Transaction.count }.by 0
        end

        it 'should return the attribute missing error' do
          manager.create
          expect(manager.errors[0]).to eq 'amount cannot be empty'
        end
      end
    end
  end
end
