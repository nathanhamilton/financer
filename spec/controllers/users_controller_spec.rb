require 'spec_helper'

describe UsersController do

  before { skip_sign_in }

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

  describe "GET new" do
    it "should create a new user" do
      get :new
      response.should be_success
    end
  end

  describe "POST create" do
    context "success" do
      it "should redirect the user to the user path" do
        post :create, user: {name: "Person2", email: "test@example.com", id: 1}
        response.should be_success
      end
    end

    context "failure" do
      it "does something" do
        User.any_instance.stub(:save).and_return false
        post :create, user: {name: '', email: "nothing%@$.com", id: 1}
        response.should render_template :new
      end
    end
  end

  describe "GET edit" do
    let!(:user) { FactoryGirl.create :user, id: 1 }
    it "should edit the user" do
      get :edit, id: 1
      response.should be_success
    end
  end

  describe "PUT update" do
    let!(:user) { FactoryGirl.create :user, id: 1 }

    context "success" do
      it "should redirect to the users profile" do
        put :update, id: 1, user: {name: "Foo", email: "test@example.com"}
        response.should be_success
      end
    end

    context "failure" do
      it "should render the edit again" do
        User.any_instance.stub(:update).and_return false
        put :update, id: 1, user: {name: "Fopp", email: "test@example.com"}
        response.should render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    let!(:user) { FactoryGirl.create :user }

    it "should delete the user" do
      delete :destroy, id: user.id
      response.should redirect_to root_path
    end
  end
end
