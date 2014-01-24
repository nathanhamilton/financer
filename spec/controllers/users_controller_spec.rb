require 'spec_helper'

describe UsersController do

  describe "GET index" do
    it "should show all the users" do
      get :index
      response.should be_success
    end
  end

  describe "GET show" do
    let!(:user) { FactoryGirl.create :user }
    it "should show the individual user" do
      get :show, id: user.id
      response.should be_success
    end
  end

  describe "POST create" do
    context "success" do
      it "should redirect the user to the user path" do
        post :create, user: { name: "Bob", email: "person28@gmail.com", id: 1 }
        response.should render :action => 'success'
      end
    end

    context "failure" do
      it "does something" do
        post :create, user: {name: '', email: "nothing%@$.com", id: 2 }
        response.should be_failure
      end
    end
  end

  describe "PUT update" do
    let!(:user) { FactoryGirl.create :user }

    context "success" do
      it "should redirect to the users profile" do
        PUT :update
        response.should redirect_to user_path(user)
      end
    end

    context "failure" do
      it "should render the show page again" do
        PUT :update
        response.should expect_success
      end
    end
  end
end
