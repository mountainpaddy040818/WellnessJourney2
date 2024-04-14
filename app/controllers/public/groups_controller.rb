# frozen_string_literal: true

class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @groups = Group.order(created_at: :desc).page(params[:page].to_i)
    @user = User.find(current_user.id)
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.owned_groups.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
      flash[:notice] = "You have successfully created a group."
      redirect_to groups_path, method: :post
    else
      flash.now[:alert] = "You cannot create a group due to blank fields."
      render "new"
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    if @group.update(group_params)
      flash[:notice] = "You have successfully updated the group."
      redirect_to groups_path
    else
      flash.now[:alert] = "You have failed to update the group."
      render "edit"
    end
  end

  def new_mail
    @group = Group.find(params[:group_id])
    # if @group.save
    #   flash[:notice] = ""
    # else
    #   flash.now[:alert] = ""
    # end
  end

  def send_mail
    @group = Group.find(params[:group_id])
    group_users = @group.users
    @mail_title = params[:mail_title]
    @mail_content = params[:mail_content]
    ContactMailer.send_mail(@mail_title, @mail_content, group_users).deliver
  end

  private
    def group_params
      params.require(:group).permit(:name, :introduction, :group_image)
    end

    def ensure_correct_user
      @group = Group.find(params[:id])
      unless @group.owner_id == current_user.id
        flash.now[:alert] = "You are not the owner of the group, so you cannot edit it."
        redirect_to groups_path
      end
    end
  
end
