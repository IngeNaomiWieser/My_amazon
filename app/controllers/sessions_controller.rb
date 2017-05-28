class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email(params[:email])   # finding user with the unique email

    if @user && @user.authenticate(params[:password])    # check is the password he provided is the same as the one we stored
      session[:user_id] = @user.id                         # if the above is true we create a session and in the session we create a user.id
      redirect_to home_path, notice: "#{@user.first_name} successfully logged in"
    else
      flash.now[:alert] = "Wrong email or password"
      render :new
    end
  end

  def destroy            # this is logging out
    session[:user_id] = nil             # deleting the user_id currently in the session. You're finishing the session. 
    redirect_to home_path, notice: 'Logged out!'
  end

end
