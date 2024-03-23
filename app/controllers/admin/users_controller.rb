class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).per(10)
  end

  def edit

  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to edit_admin_user_path(@user), notice: "You have updated user's detail successfully."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def user_params
    params.require(:user).permit(:name, :is_active)
  end

end
