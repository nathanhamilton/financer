require 'rails_helper'

describe TransactionsController, type: :controller do
  let!(:user) { FactoryGirl.create :user }
  let!(:bank) { FactoryGirl.create :bank}
  let!(:envelope) { FactoryGirl.create :envelope }

  before do
    allow(controller).to receive(:current_user).and_return user
    allow(controller).to receive(:envelope).and_return envelope
  end

  before { skip_sign_in }

  describe 'GET index' do
    let!(:transaction) { FactoryGirl.create :transaction, envelope_id: envelope.id,
                                                          user_id: user.id }

    it "shows a list of transactions belonging to envelope" do
      get :index, envelope_id: envelope.id
      expect(response).to be_success
    end
  end

  describe "GET new" do
    it 'creates a new transaction' do
      get :new, envelope_id: envelope.id
      expect(response).to be_success
    end
  end

  describe 'POST create' do

    before do
      @params = { envelope_id: envelope.id,
                  transaction: { name: 'Test mart',
                                 transaction_type: 'Check',
                                 date: '08/03/2015',
                                 amount: 4000,
                                 user_id: user.id,
                                 envelope_id: envelope.id,
                                 institutionable_id: bank.id }
                               }
    end

    context 'success' do
      it 'should redirect to the envelopes path' do
        post :create, @params
        expect(response).to redirect_to envelope_transactions_path(envelope)
      end
    end

    context 'failure' do
      it 'should render the new page' do
        post :create, envelope_id: envelope.id, transaction: { name: '',
                                                               transaction_type: '',
                                                               date: '',
                                                               amount: nil,
                                                               user_id: nil}
        expect(response).to render_template :new
      end
    end
  end

  describe "GET edit" do
    let!(:transaction) { FactoryGirl.create :transaction, envelope_id: envelope.id,
                                                          user_id: user.id }


    it "edits the transaction" do
      get :edit, envelope_id: envelope.id, id: transaction.id
      expect(response).to be_success
    end
  end

  describe "PUT update" do
    let!(:transaction) { FactoryGirl.create :transaction, envelope_id: envelope.id,
                                                          user_id: user.id }

    context 'success' do
      it "redirects to the envelopes path" do
        put :update, envelope_id: envelope.id, id: transaction.id, transaction: {name: 'New Grocery'}
        expect(response).to redirect_to envelope_transactions_path(envelope)
      end
    end

    context 'failure' do
      it "renders the edit path" do
        put :update, envelope_id: envelope.id, id: transaction.id, transaction: {name: ''}
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    let!(:transaction) { FactoryGirl.create :transaction, envelope_id: envelope.id,
                                                          user_id: user.id }
    it "redirects to the envelope path" do
      delete :destroy, envelope_id: envelope.id, id: transaction.id
      expect(response).to redirect_to envelope_transactions_path(envelope)
    end
  end
end
