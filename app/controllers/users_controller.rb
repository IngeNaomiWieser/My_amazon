class UsersController < ApplicationController

  # users are people with an account, not necessarily logged in.

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id      # Hier zeg je: Als je een user creert, log 'm automatish in.
      redirect_to home_path, notice: 'User Created!'
    else
      flash.now[:alert] = 'Problem Creating User'       #flash now pops up once. Moet voordat je rendered.
      render :new
    end

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
