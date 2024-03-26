class Admin::RecordTagsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @record_tags = RecordTag.order(created_at: :desc).page(params[:page].to_i)
    @users = User.all
  end

  def destroy
    @record_tag = RecordTag.find(params[:id])
    @record_tag.destroy
    flash[:notice] = "You have successfully deleted the tag."
    redirect_to admin_record_tags_path
  end

end
