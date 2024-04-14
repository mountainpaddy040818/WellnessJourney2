# frozen_string_literal: true

class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @groups = Group.order(created_at: :desc).page(params[:page].to_i)
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:notice] = "You have successfully deleted the group."
    redirect_to admin_groups_path
  end
end
