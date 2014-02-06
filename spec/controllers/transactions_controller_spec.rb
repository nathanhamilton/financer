require 'spec_helper'

describe TransactionsController do
  let!(:user) { FactoryGirl.create :user }
  let!(:bank) { FactoryGirl.create :bank}
  let!(:envelope) { FactoryGirl.create :envelope }

  before do
    controller.stub(:current_user).and_return user
    controller.stub(:envelope).and_return envelope
  end

  before { skip_sign_in }

  describe 'GET index' do
    let!(:transaction) { FactoryGirl.create :transaction, envelope_id: envelope.id,
                                                          user_id: user.id }

    it "shows a list of transactions belonging to envelope" do
      get :index
      response.should be_success
    end
  end

  describe "GET new" do
    it 'creates a new transaction' do
      get :new
      response.should be_success
    end
  end

  describe 'POST create' do

    context 'success' do
      it 'should redirect to the envelopes path' do
        post :create, transaction: { name: 'Test mart',
                                     transaction_type: 'Check',
                                     date: Time.now,
                                     amount: 4000,
                                     user_id: user.id,
                                     envelope_id: envelope.id}
        response.should redirect_to envelopes_path
      end
    end

    context 'failure' do
      it 'should render the new page' do
        post :create, transaction: { name: '',
                                     transaction_type: '',
                                     date: '',
                                     amount: nil,
                                     user_id: nil}
        response.should render_template :new
      end
    end
  end

  describe "GET edit" do
    let!(:transaction) { FactoryGirl.create :transaction, envelope_id: envelope.id,
                                                          user_id: user.id }

    it "edits the transaction" do
      get :edit, id: transaction.id
      response.should be_success
    end
  end

  describe "PUT update" do
    let!(:transaction) { FactoryGirl.create :transaction, envelope_id: envelope.id,
                                                          user_id: user.id }

    context 'success' do
      it "redirects to the envelopes path" do
        put :update, id: transaction.id, transaction: {name: 'New Grocery'}
        response.should redirect_to envelopes_path
      end
    end

    context 'failure' do
      it "renders the edit path" do
        put :update, id: transaction.id, transaction: {name: ''}
        response.should render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    let!(:transaction) { FactoryGirl.create :transaction, envelope_id: envelope.id,
                                                          user_id: user.id }
    it "redirects to the envelope path" do
      delete :destroy, id: transaction.id
      response.should redirect_to envelopes_path
    end
  end
end