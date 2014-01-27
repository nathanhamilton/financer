class User < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }


  protected

  def set_user_attributes
    self.user.name = @user.name
    self.user.email = @user.email
  end
end
