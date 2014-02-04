require 'spec_helper'

describe BanksController do
  let!(:user) { FactoryGirl.create :user, id: 1 }
  before do
    controller.stub(:current_user).and_return user
    ApplicationController.tap do |controller|
      controller.skip_before_filter :force_login
    end
  end

  describe "GET new" do
    it "creates a new bank" do
      get :new
      response.should be_success
    end
  end

  describe "POST create" do

    context "success" do
      it "redirects to the user page" do
        get :create, banks: { name: "TLC Bank" }
        response.should redirect_to user_path(user)
      end
    end

    context "failure" do
      it "renders the new page" do
        get :create, banks: { name: "" }
        response.should render_template :new
      end
    end
  end

  describe "GET edit" do
    let!(:bank) { FactoryGirl.create :bank, id: 1 }

    it "edits the bank" do
      get :edit, id: 1
      response.should be_success
    end
  end

  describe "PUT update" do
    let!(:bank) { FactoryGirl.create :bank, id: 1 }

    context "success" do
      it "should be successful" do
        put :update, id: 1, banks: { name: "Legacy Bank" }
        response.should redirect_to user_path(user)
      end
    end

    context "failure" do
      it "should render the edit page" do
        put :update, id: 1, banks: { name: "" }
        response.should render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    let!(:bank) { FactoryGirl.create :bank, id: 1 }

    it "deletes the selected bank" do
      delete :destroy, id: 1
      response.should redirect_to user_path(user)
    end
  end
end
