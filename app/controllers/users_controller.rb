class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You successfully registered, #{@user.full_name}, please sign in."
      redirect_to sign_in_path
    else
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end

end