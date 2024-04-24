class Public::HealthRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :destroy, :update]

  def new
    @health_record = HealthRecord.new
  end

  def create
    @health_record = HealthRecord.new(health_record_params)
    @health_record.user_id = current_user.id
    @genre = Genre.find(params[:health_record][:genre_id])
    @health_record.genre_id = @genre.id
    tag_list = params[:health_record][:tag_name].split(",")
    # タグを重複登録しようとするとこれに引っかかる
    lists = tag_list.uniq.map{|item| [item, tag_list.count(item)]}.to_h
    lists.each do |key, value|
      if(value > 1)
        flash.now[:alert] = "You cannot register the same tag name duplicately."
        render :new
        return
      end
    end

    if @health_record.save
      @genre.save
      @health_record.save_record_tags(tag_list)
      flash[:notice] = "You have successfully recorded."
      redirect_to health_record_path(@health_record)
    else
      flash.now[:alert] = "You cannot record due to blank fields."
      render :new
    end
  end

  def index
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    # "sort_by"はrailsではなくruby専用の配列であるため、"Kaminari.paginate_array"で囲ってrailsの配列へ変換する必要がある
    @health_records = Kaminari.paginate_array(HealthRecord.includes(:favorites).sort_by { |health_record| - health_record.favorites.where(created_at: from...to).count }).page(params[:page])
    @genres = Genre.all
    @tag_list = RecordTag.all
  end

  def show
    @health_record = HealthRecord.find(params[:id])
    @health_record_comment = HealthRecordComment.new
    @tag_list = @health_record.record_tags.pluck(:tag_name).join(",")
    @health_record_tags = @health_record.record_tags
  end

  def edit
    @health_record = HealthRecord.find(params[:id])
    @tag_list = @health_record.record_tags.pluck(:tag_name).join(",")
  end

  def update
    @health_record = HealthRecord.find(params[:id])
    @genre = Genre.find(params[:health_record][:genre_id])
    tag_list = params[:health_record][:tag_name].split(",")
    if @health_record.update(health_record_params)
      @genre.save
      @health_record.save_record_tags(tag_list)
      flash[:notice] = "You have successfully updated the record."
      redirect_to health_record_path(@health_record)
    else
      flash.now[:alert] = "You have failed to update the record."
      render :edit
    end
  end

  def destroy
    @health_record = HealthRecord.find(params[:id])
    @health_record.destroy
    flash[:notice] = "You have successfully deleted the record."
    redirect_to health_records_path
  end

  def search_tag
    @tag_list = RecordTag.all
    @tag = RecordTag.find(params[:record_tag_id])
    @health_records = @tag.health_records
  end

  private
    def health_record_params
      params.require(:health_record).permit(:genre_id, :name, :exercise,
        :training_content, :diet_content, :today_impression, :comment, :tag_name)
    end

    # 投稿したユーザー以外が編集できてしまうのはセキュリティ上良くないため
    def ensure_correct_user
      @health_record = HealthRecord.find(params[:id])
      unless @health_record.user_id == current_user.id
        flash.now[:alert] = "You cannot edit the comment because you are not the author."
        redirect_to health_records_path
      end
    end
end
