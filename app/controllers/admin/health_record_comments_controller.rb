class Admin::HealthRecordCommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @health_record_comments = HealthRecordComment.page(params[:page])
  end

  def destroy
    @health_record_comment = HealthRecordComment.find(params[:id])
    @health_record_comment.destroy
    flash[:notice] = "You have successfully deleted the comment."
    redirect_to admin_health_record_comments_path, notice: "You have destroyed a comment successfully."
  end

end
