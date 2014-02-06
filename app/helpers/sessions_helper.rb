module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies[:remember_token] = { value: remember_token,
                               expires: 10.minutes.from_now.utc }
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def signed_in?
     !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                        User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or(default)
    return_path = session.delete(:return_to) || default
    redirect_to return_path
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in" unless signed_in?
    end
  end
end
