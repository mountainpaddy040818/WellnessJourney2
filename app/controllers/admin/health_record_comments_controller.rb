class Admin::HealthRecordCommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def edit
    @health_record_comment = HealthRecordComment.find(params[:health_record_id])
  end
  
  def destroy
    @health_record_comment = HealthRecordComment.find(params[:health_record_id])
    if @health_record_comment.destroy(health_record_params)
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  
  def health_record_comment_params
    params.require(:health_record_comment).permit(:comment)
  end

end
