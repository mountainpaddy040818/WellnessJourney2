class Public::HealthRecordCommentsController < ApplicationController
  before_action :authenticate_user!

  before_action :ensure_correct_user, only: [:edit, :destroy, :update]

  def create
    @health_record = HealthRecord.find(params[:health_record_id])
    @health_record_comment = current_user.health_record_comments.new(health_record_comment_params)
    @health_record_comment.health_record_id = health_record.id
    @health_record_comment.save
    redirect_to redirect_back(fallback_location: root_path)
    # @health_record = HealthRecord.find(params[:health_record_id])
    # @health_record_comment = HealthRecordComment.new(comment_params)
    # @health_record_comment.user_id = current_user.id
    # @health_record_comment.health_record_id = @health_record.id
    # unless @health_record_comment.save
    #   render 'error'
    # end
  end

  def destroy
    health_record_comment = HealthRecordComment.find_by(health_record_id: params[:health_record_id], id: params[:id])
    if health_record.user_id == current_user.id
      health_record_comment.destroy
      flash[:success] = "コメントが削除されました"
    else
      flash[:error] = "自分のコメントではないため削除できません"
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:health_record_comment).permit(:comment)
  end

  def ensure_correct_user
    @health_record_comment = HealthRecordComment.find(params[:id])
    unless @health_record_comment.user_id == current_user.id
      redirect_to health_record_path(@health_record)
    end
  end

end
