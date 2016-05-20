class UsersController < ApplicationController
  before_action :require_user, only: [:index]
  before_action :require_logout, only: [:new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    if User.exists?(name: params[:name])
      render new_user_path
    else
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        cookies.signed[:user_id] = @user.id
        redirect_to rooms_path
      else
        render new_user_path
      end
    end
  end

=begin
  def show
    if User.exists?(params[:id])
      @user = User.find(params[:id])
    else
      redirect_to users_path
    end
  end

  def edit
    @user = User.find_by_id(session[:user_id])
  end
  
  def update
    @user = User.find_by_id(session[:user_id])
    
    if @user.update_attributes(user_params)
      redirect_to user_path
    else
      render 'users/edit'
    end
  end
=end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :opponent)
    end
end
