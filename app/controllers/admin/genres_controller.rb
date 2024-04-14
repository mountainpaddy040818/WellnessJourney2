# frozen_string_literal: true

class Admin::GenresController < ApplicationController
  before_action :set_genre, only: [:edit, :update]

  def index
    @genres = Genre.order(created_at: :desc) # .page(params[:page].to_i)
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "You have successfully registered the genre."
      redirect_to admin_genres_path
    else
      @genres = Genre.all
      flash.now[:alert] = "You have failed to register the genre."
      render :index
    end
  end

  def update
    if @genre.update(genre_params)
      flash[:notice] = "You have successfully updated the genre."
      redirect_to admin_genres_path
    else
      flash.now[:alert] = "You have failed to update the genre."
      render :edit
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    flash[:notice] = "You have successfully deleted the genre."
    redirect_to admin_genres_path
  end

  private
    def set_genre
      @genre = Genre.find(params[:id])
    end

    def genre_params
      params.require(:genre).permit(:name)
    end

end
