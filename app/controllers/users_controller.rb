# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged, except: [:signout]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to root_path, notice: 'Sign up success.' }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def signin
    if request.post?
      @user = User.find_by(email: params[:email], password: params[:password])
      if @user
        session[:user_id] = @user.id
        flash[:success] = "Welcome #{@user.name}"
        redirect_to root_path
      else
        flash[:warning] = "User login failed"
      end
    end
  end

  def signout
    session.delete(:user_id)
    redirect_to root_path
  end
  private

  def user_params
    params.require(:user).permit(:name, :password, :email)
  end
  
  def logged
    if current_user
      redirect_to root_path
    end
  end
end
