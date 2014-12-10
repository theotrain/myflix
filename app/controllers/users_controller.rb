class UsersController < ApplicationController
  def new
    # binding.pry
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # binding.pry
    if @user.save
      flash[:notice] = "You successfully registered, #{params[:user][:full_name]}, please sign in."
      # session[:user_id] = @user.id
      redirect_to sign_in_path
    else
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end

end