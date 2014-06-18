require 'spec_helper'

describe StaticPagesController, :type => :controller do

  describe "GET home" do
    it "should show the home page" do
      get :home
      expect(response).to be_success
    end
  end

  describe "GET about" do
    it "should redirect to the about page" do
      get :about
      expect(response).to be_success
    end
  end
end
