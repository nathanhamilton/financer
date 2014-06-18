require 'rails_helper'

describe BanksController, type: :controller do
  let!(:user) { FactoryGirl.create :user }
  before do
    allow(controller).to receive(:current_user).and_return user
    ApplicationController.tap do |controller|
      controller.skip_before_filter :force_login
    end
  end

  describe "GET new" do
    it "creates a new bank" do
      get :new
      expect(response).to be_success
    end
  end

  describe "POST create" do

    context "success" do
      it "redirects to the user page" do
        get :create, bank: { name: "TLC Bank" }
        expect(response).to redirect_to user_path(user)
      end
    end

    context "failure" do
      it "renders the new page" do
        get :create, bank: { name: "" }
        expect(response).to render_template :new
      end
    end
  end

  describe "GET edit" do
    let!(:bank) { FactoryGirl.create :bank }

    it "edits the bank" do
      get :edit, id: bank.id
      expect(response).to be_success
    end
  end

  describe "PUT update" do
    let!(:bank) { FactoryGirl.create :bank }

    context "success" do
      it "should be successful" do
        put :update, id: bank.id, bank: { name: "Legacy Bank" }
        expect(response).to redirect_to user_path(user)
      end
    end

    context "failure" do
      it "should render the edit page" do
        put :update, id: bank.id, bank: { name: "" }
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    let!(:bank) { FactoryGirl.create :bank }

    it "deletes the selected bank" do
      delete :destroy, id: bank.id
      expect(response).to redirect_to user_path(user)
    end
  end
end
