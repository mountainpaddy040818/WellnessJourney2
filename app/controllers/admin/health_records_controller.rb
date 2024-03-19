class Admin::HealthRecordsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @health_records = HealthRecord.page(params[:page]).per(10)
  end

  def edit
    @health_record = HealthRecord.find(params[:id])
    # @health_record_comment = HealthRecordComment.find(params[:id])
  end

  def destroy
    @health_record = HealthRecord.find(params[:id])
    @health_record_comment = HealthRecordComment.find(params[:id])
    if @health_record.destroy(health_record_params)
      redirect_to admin_health_records_path, notice: "You have destroyed records successfully."
    elsif @health_record_comment.destroy
      redirect_to admin_health_records_path, notice: "You have destroyed records successfully."
    end
  end

  private

  def health_record_params
    params.require(:health_record).permit(:name, :part, :comment)
  end

end
