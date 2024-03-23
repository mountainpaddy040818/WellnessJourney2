class Admin::RecordTagsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @record_tags = RecordTag.page(params[:page]).per(10)
    @users = User.all
  end

  def destroy
    @record_tag = RecordTag.find(params[:id])
    @record_tag.destroy
    redirect_to admin_record_tags_path, notice: "You have destroyed a tag successfully."
  end

end
