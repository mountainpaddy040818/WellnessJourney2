class Admin::GenresController < ApplicationController
  before_action :set_genre, only: [:edit, :update]

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: "You have created genres successfully."
    else
      @genres = Genre.all
      render :index
    end
  end

  def update
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "You have updated genre detail sucessfully."
    else
      render :edit
    end
  end
  
  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to admin_genres_path, notice: "You have destroyed a genre sucessfully."
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name)
  end


end
