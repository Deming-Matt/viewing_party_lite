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
      redirect_to "/users/#{user.id}"
    else
      redirect_to "/registration"
      flash[:error] = user.errors.full_messages
    end
  end

  def login_form
  end

  def login_user
    # binding.pry
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:name] = user.name
      flash[:success] = "Welcome, #{user.name}"
      redirect_to root_path
    else
      flash[:error] = "Incorrect credentials"
      redirect_to login_path
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
