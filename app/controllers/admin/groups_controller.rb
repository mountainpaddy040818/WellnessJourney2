class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @groups = Group.page(params[:page])
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:notice] = "You have successfully deleted the group."
    redirect_to admin_groups_path, notice: "You have destroyed a group successfully."
  end
end
