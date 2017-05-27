class UsersController < ApplicationController

  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    session[:user_id] = @user.id
    if @user.save
      redirect_to home_path, notice: 'User Created!'
    else
      flash.now[:alert] = 'Problem Creating User'
      render :new
    end

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
