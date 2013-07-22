module SessionsHelper
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    current_user = user
  end

  def sign_out
    cookies.delete(:remember_token)
    current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_user_remember_token # ||=    - if  @current_user is nil - it will assign the value of user_user_remember_token
  end

  def signed_in?
    !current_user.nil?
  end

  def deny_access
    flash[:notice] = "Please sign in to access this page"
    redirect_to signin_path
  end

  private

    def user_user_remember_token
      User.authenticate_with_salt(*remember_token) # the * seperate the one arg into two (array)
    end

  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end
end
