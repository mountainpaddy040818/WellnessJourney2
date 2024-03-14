class Public::HealthRecordsController < ApplicationController
  # ログイン済みのユーザーか？
  before_action :authenticate_user!
  # ログインしているユーザーのみが実行できるアクション
  before_action :ensure_correct_user, only: [:edit, :destroy, :update]

  def new
    # 新規作成
    @health_record = HealthRecord.new
  end

  def create
    @health_record = HealthRecord.new(health_record_params)
    @health_record.user_id = current_user.id
    if @health_record.save
      # 内容を保存する
      redirect_to health_record_path(@health_record), notice: "You have created records successfully."
    else
      # できなければnewページに戻る
      @health_records = HealthRecord.all
      render :new, notice: "errors prohibited this obj from being saved;"
    end
  end

  def index
    # レコード情報を全て取得
    @health_records = HealthRecord.all
  end

  def show
    # レコード内容を1件ずつ表示
    @health_record = HealthRecord.find(params[:id])
    @health_record_comment = HealthRecordComment.new
  end

  def edit
    @health_record = HealthRecord.find(params[:id])
  end

  def update
    @health_record = HealthRecord.find(params[:id])
    if @health_record.update(health_record_params)
      # 変更内容を適用
      redirect_to health_record_path(@health_record), notice: "You have updated records successfully."
    else
      # できなければeditページに戻る
      @health_records = HealthRecord.all
      render :edit, notice: "errors prohibited this obj from being saved;"
    end
  end

  def destroy
    @health_record = HealthRecord.find(params[:id])
    @health_record.destroy
    # レコードを削除
    redirect_to health_records_path, notice: "You have destoryed records successfully."
  end

  private

  def health_record_params
    params.require(:health_record).permit(:part, :exercise, :training_content, :diet_content, :today_impression, :comment)
  end

  def ensure_correct_user
    @health_record = HealthRecord.find(params[:id])
    unless @health_record.user_id == current_user.id
      redirect_to health_records_path
    end
  end
end
