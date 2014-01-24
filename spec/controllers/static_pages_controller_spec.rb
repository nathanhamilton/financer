require 'spec_helper'

describe StaticPagesController do

  describe "GET home" do
    it "should show the home page" do
      get :home
      response.should be_success
    end
  end

  describe "GET about" do
    it "should redirect to the about page" do
      get :about
      response.should be_success
    end
  end
end
