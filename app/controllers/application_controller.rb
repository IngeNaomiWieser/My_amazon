class ApplicationController < ActionController::Base


  protect_from_forgery with: :exception

  def user_signed_in?
    session[:user_id].present?
  end

  #👇 makes the method 👆 available to all my views
  helper_method :user_signed_in?

  def current_user
    #find by will just return nill
    @current_user ||= User.find_by(id: session[:user_id]) if user_signed_in?
  end

helper_method :current_user #, :user_signed_in?

def authenticate_user!
  if !user_signed_in?
    redirect_to new_session_path, notice: 'Please sign in!'
  end
end

end
