class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @groups = Group.page(params[:page]).per(10)
  end
  
  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_back(follback_location: root_path)
  end
end
