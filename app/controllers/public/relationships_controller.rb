class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    render 'btn'
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
    render 'btn'
    # redirect_back(fallback_location: root_path)
  end

  # def create
  #   @user = User.find(params[:user_id])
  #   following = Relationship.create(follower_id: params[:user_id], following_id: current_user.id)
  # end

  # def destroy
  #   @user = User.find(params[:user_id])
  #   following = Relationship.find_by(follower_id: params[:user_id], following_id: current_user.id)
  #   following.destroy
  # end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end

end
