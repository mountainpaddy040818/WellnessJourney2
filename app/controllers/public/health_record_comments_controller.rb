class Public::HealthRecordCommentsController < ApplicationController
  def create
    @health_record = HealthRecord.find(params[:health_record_id])   
  end

  def destroy
    
  end
end
