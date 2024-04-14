# frozen_string_literal: true

class Public::FavoritesController < ApplicationController

  def create
    @health_record = HealthRecord.find(params[:health_record_id])
    favorite = current_user.favorites.new(health_record_id: @health_record.id)
    favorite.save
  end

  def destroy
    @health_record = HealthRecord.find(params[:health_record_id])
    favorite = current_user.favorites.find_by(health_record_id: @health_record.id)
    favorite.destroy
  end

end
