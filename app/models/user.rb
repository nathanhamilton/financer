class User < ActiveRecord::Base

  protected

  def set_user_attributes
    self.user.name = @user.name
    self.user.email = @user.email
  end
end
