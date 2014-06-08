require 'spec_helper'

describe User::EnvelopesController do
  let!(:user) { FactoryGirl.create :user }
  let!(:bank) { FactoryGirl.create :bank }

  before do
    controller.stub(:current_user).and_return user
    ApplicationController.tap do |controller|
      controller.skip_before_filter :signed_in_user
    end
  end

  describe "GET index" do
    let(:envelope) { FactoryGirl.create :envelope }

    it "shows the users list of envelopes" do
      get :index
      response.should be_success
    end
  end

  describe "GET new" do
    it "creates a new envelope" do
      get :new
      response.should be_success
    end
  end

  describe "POST create" do

    context "success" do
      it "creates the envelope" do
        post :create, envelope: { category: 'Car', total: 30, bank_id: bank.id }
        response.should redirect_to dashboard_path
      end
    end

    context "failure" do
      it "renders the new page" do
        post :create, envelope: { category: '', total: nil, bank_id: nil }
        response.should render_template :new
      end
    end
  end

  describe "GET edit" do
    let!(:envelope) { FactoryGirl.create :envelope }

    it "updates the envelope" do
      get :edit, id: envelope.id
      response.should be_success
    end
  end

  describe "PUT update" do
    let!(:envelope) { FactoryGirl.create :envelope }

    context "success" do
      it "redirects to user path" do
        put :update, id: envelope.id, envelope: { category: "home", total: 200, bank_id: bank.id }
        response.should redirect_to dashboard_path
      end
    end

    context "failure" do
      it "renders the edit page" do
        put :update, id: envelope.id, envelope: { category: '' }
        response.should render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    let!(:envelope) { FactoryGirl.create :envelope }

    it "changes the envelope count by 1" do
      delete :destroy, id: envelope.id
      response.should redirect_to dashboard_path
    end
  end
end
