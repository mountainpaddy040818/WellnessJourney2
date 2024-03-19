class Admin::HealthRecordCommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @health_record_comments = HealthRecordComment.page(params[:page]).per(10)
    @users = User.page(params[:page]).per(10)
  end
  
  def destroy
    health_record_comment = HealthRecordComment.find_by(health_record_id: params[:health_record_id], id: params[:id])
    health_record_comment.destroy(health_record_comment_params)
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def health_record_comment_params
    params.require(:health_record_comment).permit(:comment)
  end

end
