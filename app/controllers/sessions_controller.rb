class SessionsController < ApplicationController
  before_action :require_user, only: [:destroy]
  before_action :require_logout, only: [:new, :create]
  
  def new
  end

  def create
    @user = User.find_by_name(params[:session][:name])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      cookies.signed[:user_id] = @user.id
      redirect_to rooms_path
    else
      render 'sessions/new'
    end
  end

  def destroy
    session[:user_id] = nil
    cookies.signed[:name] = nil
    redirect_to 'sessions/new'
  end
end
