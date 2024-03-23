class Admin::HealthRecordsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @health_records = HealthRecord.page(params[:page]).per(10)
  end

  def edit
    @health_record = HealthRecord.find(params[:id])
  end

  def destroy
    @health_record = HealthRecord.find(params[:id])
    @health_record.destroy
    redirect_to admin_health_records_path, notice: "You have destroyed a record successfully."
  end

  private

  def health_record_params
    params.require(:health_record).permit(:name, :genre_id, :exercise, :training_content, :diet_content, :today_impression)
  end

end
