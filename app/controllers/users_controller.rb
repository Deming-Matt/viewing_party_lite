class UsersController < ApplicationController

  def index

  end

  def new
    @user_new = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    user = User.create(user_params)
    # binding.pry
    if user.save
      session[:user_id] = user.id
      redirect_to root_path
      flash[:success] = "Welcome, #{user.email}!"
    else
      redirect_to "/registration"
      flash[:error] = user.errors.full_messages
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
