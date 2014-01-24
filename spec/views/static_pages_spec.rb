require 'spec_helper'

describe '/' do
  visit 'static_pages#home'
  it "should have signin form" do
    page.should have_css('.form')
  end
end
