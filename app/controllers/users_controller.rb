class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @user.save
      redirect_to posts_path
    else 
      redirect_to :signup
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :role, :password, :password_confirmation)
  end
end
