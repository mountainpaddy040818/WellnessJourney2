class Public::UsersController < ApplicationController
  # ログイン済みのユーザーか？
  before_action :authenticate_user!
  # ゲストユーザーのみに実行される処理でここではedit、updateアクションのみ
  before_action :ensure_guest_user, only: [:edit]

  def index
    # 登録済みユーザーの情報を全て取得
    @users = User.all
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
      redirect_to user_path(@user), notice: "You have updated user's detail successfully."
    else
      render :edit
    end
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
end
