class Public::UsersController < ApplicationController
  # ログイン済みのユーザーか？
  before_action :authenticate_user!
  # url直接入力を防ぐ
  before_action :ensure_correct_user, only: [:edit, :update]
  # ゲストユーザーのみに実行される処理でここではeditアクションのみ
  before_action :ensure_guest_user, only: [:edit]

  before_action :set_user, only: [:followings, :followers]

  def index
    # 登録済みユーザーの情報を全て取得
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    # 選択したユーザーの情報を表示
    @user = User.find(params[:id])
  end

  def update
    # 選択したユーザーの情報を表示
    @user = User.find(params[:id])
    # ユーザー情報の変更に成功したら指定のメッセージを表示
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

  #ストロングパラメータで入力した情報を許可して保存する
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :target)
  end

  # ゲストユーザーが編集画面に遷移しようと試みた時の処理
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user),
      notice: "Guest users are unable to navigate to the profile editing page."
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
