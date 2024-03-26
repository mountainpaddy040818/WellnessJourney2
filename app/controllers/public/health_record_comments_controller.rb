class Public::HealthRecordCommentsController < ApplicationController
  before_action :authenticate_user!

  before_action :ensure_correct_user, only: [:edit, :destroy, :update]

  def create
    @health_record = HealthRecord.find(params[:health_record_id])
    @health_record_comment = current_user.health_record_comments.new(health_record_comment_params)
    @health_record_comment.health_record_id = @health_record.id
    if @health_record_comment.save
      flash[:notice] = "You have successfully commented."
    else
      flash.now[:alert] = "You have failed to comment."
    end
  end

  def destroy
    health_record_comment = HealthRecordComment.find_by(health_record_id: params[:health_record_id], id: params[:id])
    if health_record_comment.user_id == current_user.id
      health_record_comment.destroy
      flash[:notice] = "You have successfully deleted the comment."
    else
      flash.now[:alert] = "You failed to delete the comment."
    end
  end

  private
    def health_record_comment_params
      params.require(:health_record_comment).permit(:comment)
    end

    def ensure_correct_user
      @health_record_comment = HealthRecordComment.find(params[:id])
      unless @health_record_comment.user_id == current_user.id
        flash.now[:alert] = "You cannot edit the comment because you are not the creator."
        redirect_to health_record_path(@health_record)
      end
    end

end
