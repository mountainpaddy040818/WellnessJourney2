class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.order(created_at: :desc).page(params[:page].to_i)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have successfully updated the user information."
      redirect_to edit_admin_user_path(@user)
    else
      flash.now[:alert] = "You have failed to update the user information."
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "You have successfully deleted the user."
    redirect_to admin_users_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :is_active)
    end
end
