class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  before_action :set_user, only: [:followings, :followers]

  def index
    @users = User.order(created_at: :desc).page(params[:page].to_i)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have successfully updated the user information."
    else
      render :edit
    end
  end

  def followings
    user = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = @user.followers
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:health_record_id)
    @favorite_records = HealthRecord.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :target)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user)
      flash[:notice] = "Guest users are unable to navigate to the profile editing page."
    end
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

end
