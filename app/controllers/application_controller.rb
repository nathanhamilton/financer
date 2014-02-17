class ApplicationController < ActionController::Base
  before_action :signed_in_user
  protect_from_forgery with: :exception
  include SessionsHelper
end
