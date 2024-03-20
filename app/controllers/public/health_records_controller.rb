class Public::HealthRecordsController < ApplicationController
  # ログイン済みのユーザーか？
  before_action :authenticate_user!
  # url直接入力を防ぐ
  before_action :ensure_correct_user, only: [:edit, :destroy, :update]

  def new
    # 新規作成
    @health_record = HealthRecord.new
  end

  def create
    @health_record = HealthRecord.new(health_record_params)
    @health_record.user_id = current_user.id
    @genre = Genre.find(params[:health_record][:genre_id])
    @health_record.genre_id = @genre.id
    tag_list = params[:health_record][:tag_name].split(',')

    if @health_record.save
      @genre.save
      @health_record.save_record_tags(tag_list)
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
    @health_records = HealthRecord.page(params[:page])
    @genres = Genre.all
    @tag_list = RecordTag.all
  end

  def show
    # レコード内容を1件ずつ表示
    @health_record = HealthRecord.find(params[:id])
    @health_record_comment = HealthRecordComment.new
    @tag_list = @health_record.record_tags.pluck(:tag_name).join(',')
    @health_record_tags = @health_record.record_tags
  end

  def edit
    @health_record = HealthRecord.find(params[:id])
    @genre = Genre.find(params[:id])
    @tag_list = @health_record.record_tags.pluck(:tag_name).join(',')
    # @genre = Genre.find(params[:id])
  end

  def update
    @health_record = HealthRecord.find(params[:id])
    @genre = Genre.find(params[:id])
    tag_list = params[:health_record][:tag_name].split(',')
    if @health_record.update(health_record_params)
      @genre.save
      @health_record.save_record_tags(tag_list)
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

  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list = RecordTag.all
    #検索されたタグを受け取る
    @tag = RecordTag.find(params[:record_tag_id])
    #検索されたタグに紐づく投稿を表示
    @health_records = @tag.health_records
  end

  private

  def health_record_params
    params.require(:health_record).permit(:genre_id, :name, :part, :exercise, :training_content, :diet_content, :today_impression, :comment, :tag_name)
  end

  def ensure_correct_user
    @health_record = HealthRecord.find(params[:id])
    unless @health_record.user_id == current_user.id
      redirect_to health_records_path
    end
  end
end
