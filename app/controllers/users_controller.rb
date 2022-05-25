class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    @user.update(user_params)
    if @user.save!
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to :trips_path #route à décider, vu qu'on a pas d'index pour users
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :photo)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
