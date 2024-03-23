class Admin::HealthRecordCommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @health_record_comments = HealthRecordComment.page(params[:page]).per(10)
    @users = User.page(params[:page]).per(10)
  end

  def destroy
    @health_record_comment = HealthRecordComment.find(params[:id])
    @health_record_comment.destroy
    redirect_to admin_health_record_comments_path, notice: "You have destroyed a comment successfully."
  end

end
